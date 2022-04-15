(*fichier main.ml *)
let _ = (*main en OCaml*)
let channel_in = if (Array.length Sys.argv)>1 then (open_in Sys.argv.(1)) else (stdin) in
let channel_out = if (Array.length Sys.argv)>1 then (open_out (String.concat Sys.argv.(1) ["";".jsm"])) else (stdout) in
try
  let lexbuf = Lexing.from_channel stdin in (*lexeur lancé sur stdin*)
  while true do (*on ne s'arrête pas*)
  Parseur.main Lexeur.token lexbuf (*parseur une ligne*)
  |> Printf.fprintf channel_out "%s\n%!"  ; 
  done
  with
  | Lexeur.Eof -> exit 0 (*impossible*)
  | Lexeur.TokenInconu (*erreur de lexing*)
  | Parsing.Parse_error -> (*erreur de parsing*)
  Printf.printf ("Ceci n'est pas une expression arithmetique\n")