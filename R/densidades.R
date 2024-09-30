densidades = function(df) {
  for (j in 1:3){
    df_i = df %>% filter(frequency == df$frequency[j])
    densidade_min = density(df_i$drive_min)
    densidade_max = density(df_i$drive_max)
    densidade_df = data.frame(x_min = densidade_min$x, 
                              y_min = densidade_min$y,
                              x_max = densidade_max$x,
                              y_max = densidade_max$y)
    mean_min = mean(df_i$drive_min)
    sd_min = sd(df_i$drive_min)
    mean_max = mean(df_i$drive_max)
    sd_max = sd(df_i$drive_max)
    
    
    g1 = densidade_df %>% 
      ggplot(aes(x = x_min, y = y_min)) +
      geom_line() +
      geom_vline(xintercept = mean_min, col = "red") +
      annotate("text", x = -Inf, y = Inf, 
               label = glue("Média: {round(mean_min, 6)}\nDesvio Padrão: {sd_min}"),
               hjust = 0, vjust = 1, color = "black", size = 4) +
      labs(x = "Drive esquerdo", 
           y = "Total", 
           title = "Densidade - Drive esquerdo", 
           subtitle = glue("Frequência: {df$frequency[j]}"), 
           caption = glue("Amostra: {i}"))
    
    g2 = densidade_df %>% 
      ggplot(aes(x = x_max, y = y_max)) +
      geom_line() +
      geom_vline(xintercept = mean_max, col = "red") +
      annotate("text", x = -Inf, y = Inf, 
               label = glue("Média: {round(mean_max, 6)}\nDesvio Padrão: {sd_max}"),
               hjust = 0, vjust = 1, color = "black", size = 4) +
      labs(x = "Drive Direito", 
           y = "Total", 
           title = "Densidade - Drive Direito", 
           subtitle = glue("Frequência: {df$frequency[j]}"), 
           caption = glue("Amostra: {i}"))
    
    
    ggsave(glue("resultados/{i}/densidades/den_esquerdo{j}.png"), plot = g1, create.dir = T)
    ggsave(glue("resultados/{i}/densidades/den_direito{j}.png"), plot = g2)
  }
}