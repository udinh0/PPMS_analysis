func = function(drive, signal, bin, frequency, images = FALSE) {
  require(tidyverse)
  require(progress)
  n = length(drive) / (max(bin) + 1)
  drive_min = c()
  drive_max = c()
  bin_min = c()
  bin_max = c()
  frequency_df = c()
  pb = progress_bar$new(
    format = "  downloading [:bar] :percent eta: :eta",
    total = n, clear = FALSE, width = 60
  )
  
  for (i in 1:n) {
    drive_tmp = drive[1:(max(bin) + 1)]
    signal_tmp = signal[1:(max(bin) + 1)]
    frequency_tmp = frequency[1:(max(bin) + 1)]
    
    tmp = drive[1:33]
    drive_tmp = append(drive_tmp, tmp)
    drive_tmp = drive_tmp[-c(1:33)]
    
    df = data.frame(drive = -drive_tmp,
                    signal = signal_tmp,
                    frequency = frequency_tmp,
                    bin = 0:max(bin))
    if (images) {
      g = df %>% 
        ggplot(aes(x = drive, y = signal)) +
        geom_point() +
        geom_path(linewidth = 2) +
        geom_hline(yintercept = 0, lty = 2, col = "red") +
      labs(title = paste("Histerese", sep = " ", i, "Frequência =", frequency_tmp[1]))
      ggsave(paste("resultados/histereses/histerese", sep = "", i, ".png"), plot = g, create.dir = T, width = 7, height =  7)
      graphics.off()
    }
    pb$tick()
    
    df = df[order(abs(df$signal))[1:4],]
    
    if (df[order(abs(df$signal))[2],]$bin %in% c((df[order(abs(df$signal))[1],]$bin - 2):(df[order(abs(df$signal))[1],]$bin + 2))) {
      df = df[-2,]
    }
    
    bin_min = append(bin_min, df[order(abs(df$signal))[1:2],] %>% filter(drive == min(df[order(abs(df$signal))[1:2],]$drive)) %>% pull(bin))
    bin_max = append(bin_max, df[order(abs(df$signal))[1:2],] %>% filter(drive == max(df[order(abs(df$signal))[1:2],]$drive)) %>% pull(bin))
    drive_min = append(drive_min, min(df[order(abs(df$signal))[1:2],]$drive))
    drive_max = append(drive_max, max(df[order(abs(df$signal))[1:2],]$drive))
    frequency_df = append(frequency_df, frequency[1])
    
    drive = drive[-c(1:(max(bin) + 1))]
    signal = signal[-c(1:(max(bin) + 1))]
    frequency = frequency[-c(1:(max(bin) + 1))]
    
  }
  df = data.frame(drive_min = drive_min,
                  drive_max = drive_max,
                  frequency = frequency_df,
                  bin_min = bin_min,
                  bin_max = bin_max)
  return(df)
}
