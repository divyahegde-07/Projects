
# PEFT Fine-Tuning BART model using LoRA technique

## Agenda 

This notebook intends to use the BART large model to summarize the samsum dataset. The SAMSum dataset contains about 16k messenger-like conversations with summaries.

BART is a transformer encoder-decoder (seq2seq) model with a bidirectional (BERT-like) encoder and an autoregressive (GPT-like) decoder. BART is pre-trained by (1) corrupting text with an arbitrary noising function, and (2) learning a model to reconstruct the original text.

BART is a very large model with 406M parameters. Fine-tuning this model will be a very cumbersome process that would require a lot of resources and would be impossible without GPU resources. This makes fine-tuning infeasible.

## PEFT
There is a way to get over this obstacle - Parameter Efficient Fine-Tuning (PEFT).

The idea behind PEFT is to train only a small number of model parameters while freezing most parameters of the pre-trained LLMs.

There are different methods with PEFT - LoRA, Prefix Tuning, AdaLoRA, Prompt Tuning etc.,

### Low-Rank Adaptation (LoRA)
This technique significantly speeds up the fine-tuning process of LLMs while consuming less memory.

The key idea is to represent the weights using two smaller matrices achieved through low-rank decomposition. These matrices can be trained to adapt to new data while minimizing the overall number of modifications.

There are several advantages to using LoRA. Firstly, it greatly enhances the efficiency of fine-tuning by reducing the number of trainable parameters. Additionally, LoRA is compatible with various other parameter-efficient methods and can be combined with them. Models fine-tuned using LoRA demonstrate performance comparable to fully fine-tuned models.  Importantly, LoRA doesn't introduce any additional inference latency since adapter weights can be seamlessly merged with the base model.

## Future work

- This can be made better by using QLoRA which is quantized LoRA.
- This is achieved through BitsAndBytesConfig and is passed as parameter when loading the pretrained model.

## Results

- The fine-tuning time was cut-down drastically as a result of using PEFT technique.

- This makes sense as we trained only 0.2% of the total parameters - only 1.1M parameters were trained of the 409M parameters.

- After training for 5 epochs, the ROUGE scores definitely improved. 

![Screenshot 1](https://raw.github.com/divyahegde-07/Projects/main/LLM%20Assignments/Fine-tuning%20LLMs/ROUGEScore.png)

The summarization without fine-tuning resulted in the model hallucinating. But the summarization was nonetheless coherent for this example.

![Screenshot 2](https://raw.github.com/divyahegde-07/Projects/main/LLM%20Assignments/Fine-tuning%20LLMs/SummarizationWOFT.png)

After fine-tuning, the model summarized much better and did not hallucinate for the very same example.

![Screenshot 3](https://raw.github.com/divyahegde-07/Projects/main/LLM%20Assignments/Fine-tuning%20LLMs/SummarizationWFT.png)
