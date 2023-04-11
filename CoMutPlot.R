library(maftools)
library(readr)

# This program plots a co-mut plot using the maftools package. It requires MAF format files to buold the plot. 

#  Reading Clinical Data
clin_df <- read_tsv('Clin_updated.txt')


#Reading CNV data ( 1/8/22 : removed LAs)
cndata <- read.csv('WCM_CNV.csv', 
                   header = TRUE, sep = ",")

# Read SNV & CNV data in MAF format
#all_maf = read.maf('WCM.maf', 
                   #isTCGA = FALSE, clinicalData = clin_df, cnTable = cndata )

# Read SNV data in MAF format
all_maf = read.maf('WCM.maf',
                   isTCGA = FALSE, clinicalData = clin_df )

all_maf

############# Custom colors #####################

vc_cols = RColorBrewer::brewer.pal(n = 8, name = 'Paired')
names(vc_cols) = c(
  'Frame_Shift_Del',
  'Missense_Mutation',
  'Nonsense_Mutation',
  'Multi_Hit',
  'Frame_Shift_Ins',
  'In_Frame_Ins',
  'Splice_Site',
  'In_Frame_Del'
)


colsAnn = list(
  'BiopsyVSDocetaxel' = c('After' = 'red', 'Before/NA' = 'blue'),
  'BiopsyVSARSI' = c('After' = 'red', 'Before/NA' = 'blue'),
  'Presentation' = c('Synchronous' = 'pink', 'Metachronous' = 'yellow'),
  'DiseaseVolume' = c('Low' = 'purple', 'High' = 'orange'),
  'BiopsySite' = c("Bone" = '#E41A1C' , "Liver" = '#377EB8', "LN" = '#4DAF4A' , "Prostate" = '#984EA3',
                   "Prostate"= '#FF7F00', "CNS" = '#FFFF33', "Soft tissue" = '#A65628')
)
###################################################
#annot_colors = list(BiopsyVSDocetaxel = biopsyVsDocColors)

pdf(file = "WCM_ALL_mdm68_Waterfall_color_test.pdf", width = 20, height = 10) 

#Reading TMB data , because we want to use our TMB instead of maftools TMB
tmbdata <- read.csv('WCM_TMB.csv', 
                    header = TRUE, sep = ",")

#one clinical indicator(Numeric) or by providing a two column data.frame contaning sample names and values for each sample
#oncoplot(maf = all_maf, clinicalFeatures = c('BiopsySite','Presentation','DiseaseVolume',
                                             #'BiopsyVSDocetaxel','BiopsyVSARSI'), anno_height = 4,barcode_mar=10,
        #drawColBar = TRUE, topBarData= tmbdata, removeNonMutated = FALSE)

oncoplot(maf = all_maf, 
         clinicalFeatures = c("BiopsyVSDocetaxel","BiopsyVSARSI","Presentation","DiseaseVolume","BiopsySite"), 
         colors = vc_cols,
         anno_height = 4,
         barcode_mar=10,
         drawColBar = TRUE, 
         removeNonMutated = FALSE, 
         annotationColor = colsAnn, 
         topBarData= tmbdata)
dev.off()
