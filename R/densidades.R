densidades = function(df) {
  for (i in 1:3){
    df_i = df %>% filter(frequency == df$frequency[i])
    densidade_min = density(df_i$drive_min)
    densidade_max = density(df_i$drive_max)
    densidade_df = data.frame(x_min = densidade_min$x, 
                              y_min = densidade_min$y,
                              x_max = densidade_max$x,
                              y_max = densidade_max$y)
    
    
    g1 = densidade_df %>% 
      ggplot(aes(x = x_min, y = y_min)) +
      geom_line() +
      labs(x = "Drive esquerdo", 
          y = "Total", 
           title = "Densidade - Drive esquerdo", 
          subtitle = glue("Frequência: {df$frequency[i]}"), 
          caption = glue("Amostra: {config$data}"))
  
    g2 = densidade_df %>% 
      ggplot(aes(x = x_max, y = y_max)) +
      geom_line() +
      labs(x = "Drive direito", 
           y = "Total", 
           title = "Densidade - Drive direito", 
           subtitle = glue("Frequência: {df$frequency[i]}"), 
           caption = glue("Amostra: {config$data}"))
    
  
    ggsave(glue("resultados/densidades/den_esquerdo{i}.png"), plot = g1, create.dir = T)
    ggsave(glue("resultados/densidades/den_direto{i}.png"), plot = g2)
  }
}