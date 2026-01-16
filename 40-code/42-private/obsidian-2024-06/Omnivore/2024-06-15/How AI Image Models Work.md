---
id: bfbf288a-2738-11ef-98f2-93bf9aa7e1fc
---

# How AI Image Models Work
Tags: #Omnivore

[Read on Omnivore](https://omnivore.app/me/how-ai-image-models-work-19002a0dffb)
[Read Original](https://every.to/p/how-ai-image-models-work)


## Content
[ ![](https://proxy-prod.omnivore-image-cache.app/84x24,sgwXMkmq-FqseYZAcYK7ZllpdQHHjHnOKEWG_WLlobHo/https://d24ovhgu8s7341.cloudfront.net/static/every-logo.png) ](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vIiwicG9zaXRpb24iOjB9) 

## [An entirely non-technical explanation of image generators](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktaW1hZ2UtbW9kZWxzLXdvcmsiLCJwb3NpdGlvbiI6Mn0=) 

by [Nir Zicherman](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vQG5pcnppY2hlcm1hbiIsInBvc2l0aW9uIjozfQ==)

![](https://proxy-prod.omnivore-image-cache.app/600x0,sA0sAhGWvYBTSmDo7hhn7M9kG-bt1NMQG_-IzaiMUcPw/https://d24ovhgu8s7341.cloudfront.net/uploads/post/cover/3124/M-Cover.png) 

DALL-E/Every illustration.

_The details of today’s AI wave are many and can be difficult to understand, but they are built on basic and intuitive ideas. That’s why I love stories like_ **_Nir Zicherman_**_’s. He breaks down a subject that seems intimidating and complicated into_ [_something simple_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktd29ya3MiLCJwb3NpdGlvbiI6NH0=)_. In today’s world, understanding how AI works is power—and that’s why I’m to excited publish this story to help make that understanding more widespread.—_[_Dan Shipper_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vQGRhbnNoaXBwZXIiLCJwb3NpdGlvbiI6NX0=) 

_Was this newsletter forwarded to you?_ [_Sign up_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vYWNjb3VudCIsInBvc2l0aW9uIjo2fQ==) _to get it in your inbox._

---

I can vividly recall the day I got access to the DALL-E beta. It was the summer of 2022\. For months, I’d been on the waitlist, hearing about this magical new tool that could take _any_ description and output a matching image.

One of the first images I created used the prompt “80s tv commercial showing a hippo fighting a pegasus.” This was the output:

[![](https://proxy-prod.omnivore-image-cache.app/600x0,ssDOBoFcE3oR2zMWv-utGnMVDIO63lI3ii85AdF25CME/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3124/optimized_AD_4nXf-a9T2iSUXMbTa5gP5h2BkH8_T198f6xPvF_9ZeJA1KVkQq1yOggsHRRtZomL6NoW1wDq9vY0ObZPVZjOCI4r6axks64oAhjhOTHq4klgcNBsNzmUggP0H.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyNC9vcHRpbWl6ZWRfQURfNG5YZi1hOVQyaVNVWE1iVGE1Z1A1aDJCa0g4X1QxOThmNnhQdkZfOVplSkExS1ZrUXExeU9nZ3NIUlJ0Wm9tTDZOb1cxd0RxOXZZME9iWlBWWmpPQ0k0cjZheGtzNjRvQWhqaE9USHE0a2xnY05Cc056bVVnZ1AwSC5wbmciLCJwb3NpdGlvbiI6N30=)

_All images courtesy of the author._

Fast-forward to today, less than two years after the advent of that mind-blowing capability. The same prompt, in ChatGPT 4o, yields this:

[![](https://proxy-prod.omnivore-image-cache.app/600x0,sO01QhGRj4myfIi47BveaZ6385eW7DGSWZ9U7d8EZ-VQ/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3124/optimized_AD_4nXdEmxEFfcy6FifsVqxQPVLsZNOXwImffOJ7aXTaYP_SzUrE0zowsKc1e7Zd2YWr5zpF7s7LcOhs_eHdeaqWUK2ntHHnY4NYODaPU721_1uDobL21qeMzWhw.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyNC9vcHRpbWl6ZWRfQURfNG5YZEVteEVGZmN5NkZpZnNWcXhRUFZMc1pOT1h3SW1mZk9KN2FYVGFZUF9TelVyRTB6b3dzS2MxZTdaZDJZV3I1enBGN3M3TGNPaHNfZUhkZWFxV1VLMm50SEhuWTROWU9EYVBVNzIxXzF1RG9iTDIxcWVNeldody5wbmciLCJwb3NpdGlvbiI6OH0=)

Despite persistent flaws and hallucinations (that hippo has three legs!), it is mind-boggling how far we’ve come in such a short period of time. Dream up _anything_, with any text description, and a machine will create a matching image in seconds.

Yet despite the technology’s sudden ubiquity, few people who regularly use it understand how it works or how these improvements come about.

Several months ago, I published a primer that explained [how large language models (LLMs) work](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktd29ya3MiLCJwb3NpdGlvbiI6OX0=) using no technical language. I’d like to do the same now for image generators. As with LLMs, I believe that the core concepts are straightforward. The fancy calculus and ground-breaking computing power used to train these models is simply the application of something we can explain with an analogy to a kids’ game.

## The story plot game

Let's imagine inventing a new game intended to teach children how to unleash their creativity and come up with fictional stories. Left to their own devices, children will typically write about topics that interest them. But our intention is to broaden their horizons and encourage them to think outside the box, to be comfortable ideating and crafting stories about _any_ topic.

We're going to teach this incrementally. We’ll begin with a skill that (at first glance) might seem unrelated: identifying _existing_ story plots.

The children will be presented with a sentence containing a single typo. If they find the typo, they will uncover the plot of a well-known film. Here it goes:

_A princess with magical towers accidentally sets off an eternal winter in her kingdom._

I imagine most children would successfully identify that the outlying word is _towers_ and that the word with which it should be replaced is _powers_. (The film, of course, is _Frozen_.)

Let's make it a bit harder. This time, the error won't be a rhyming word but an entirely different word altogether. For instance:

_A clown fish gets separated from his banana and must find his way home._

This time, a child familiar with _Finding Nemo_ will hopefully recognize the word _banana_ as a typo and replace it with the word _father_ to decipher the correct plot. But here's an interesting implication that comes with this second example: Had the child replaced _banana_ with _best friend_, the resulting sentence would be perfectly logical and the plot perfectly plausible, even if it did not accurately summarize any particular Pixar film.

## Getting noisier

We may seem far removed from our eventual goal of mirroring generative image models, but there is more happening here than it might seem at first glance. We’re teaching the children to identify compelling story plots hidden somewhere in a summary rife with errors.

Let's give these errors another name: noise. And let's turn the difficulty up a notch and replace two words in a given plot:

_An outcast lion faces his barbecues and returns home to challenge the popsicle who killed his father._

This time, a child might make several attempts. Eventually, they might get the answer right and correctly replace _barbecues_ with _fears_ and _popsicle_ with _uncle_. But they just as well could replace _barbecues_ with _critics_ and _popsicle_ with _tiger_, and the plot would be perfectly plausible (despite no longer being that of _The Lion King_). 

The children have now learned to break down the task into multiple steps, uncovering plots (even if they aren’t precise descriptions of existing movies) by detecting erroneous words (i.e., noise).

And this process can continue. What about a plot where _most_ of the words are wrong?

_A jumping omelet escapes a bass and stands effectively._

Don’t ask me what plot this is meant to represent! But place this sentence in front of a creative child and tell them to replace individual words until a compelling plot emerges, and I’m confident you’ll have a blockbuster hit on your hands.

The game eventually reaches the stage in which _all_ of the words in the sentence are wrong. The sentence, in other words, is pure noise:

_Gold scissor out headphone neat typewriter spinach._

By learning to succeed at this game, the children have inadvertently been taught to do something special: Given a random sequence of words, they will uncover a coherent and compelling plot within it.

## Connecting the dots

This juvenile game we’ve invented is similar to how image models are trained. Engineers at OpenAI and other companies take real images (for example, photographs or paintings), and add a little noise to them in the form of randomly colored dots (pixels). Just as the children in our game were asked to uncover the hidden plot, the model is instructed to remove the noisy pixels and return a coherent image:

[![](https://proxy-prod.omnivore-image-cache.app/600x0,sxPv9faYdBnPYeQoOH6t9MQO5PwqbQqVFqCknMG2Vl0c/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3124/optimized_AD_4nXf7OLKgw0V3BWJ0DFzKj3sjSGSxhLovWipLDSgVlNjotw8wDXf0HKLdUwY2DBqEww6WT1BokIee-3XaKXIlvn-r1W7QGDX_MaspNDEJJkEQAJ6BRvCh8pgN.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyNC9vcHRpbWl6ZWRfQURfNG5YZjdPTEtndzBWM0JXSjBERnpLajNzalNHU3hoTG92V2lwTERTZ1ZsTmpvdHc4d0RYZjBIS0xkVXdZMkRCcUV3dzZXVDFCb2tJZWUtM1hhS1hJbHZuLXIxVzdRR0RYX01hc3BOREVKSmtFUUFKNkJSdkNoOHBnTi5wbmciLCJwb3NpdGlvbiI6MTB9)

After many iterations and sample data, a computer can become quite adept at cleaning up the input and returning the original image. At that stage, we can add even more noise. The children learned to replace individual words in the unintelligible sentences until a substantive plot emerged. The model too can iterate through several steps of noise removal: 

[![](https://proxy-prod.omnivore-image-cache.app/600x0,sJFMU-w0Tn7JETBFAVwgIsC59e4qfB3mINLuYAYpeZQ0/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3124/optimized_AD_4nXfjh5o1NRfb7TKBqE0tLb_wgGTbeOTrF10OS4h5xptvbGWakdZb7hehGTtFGkZ8vVEPYNjKMn93EW4emjB0sTFneKpx1u6alGYQ8JXA87ErWNQm6bmzxsXd.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyNC9vcHRpbWl6ZWRfQURfNG5YZmpoNW8xTlJmYjdUS0JxRTB0TGJfd2dHVGJlT1RyRjEwT1M0aDV4cHR2YkdXYWtkWmI3aGVoR1R0RkdrWjh2VkVQWU5qS01uOTNFVzRlbWpCMHNURm5lS3B4MXU2YWxHWVE4SlhBODdFcldOUW02Ym16eHNYZC5wbmciLCJwb3NpdGlvbiI6MTF9)

Doing this enough times teaches an AI model to find rational images in noise. After a few dozen de-noising iterations, pure noise can be turned into a cat:

[![](https://proxy-prod.omnivore-image-cache.app/600x0,sYEFs5d41YGChnrrPgIcj-kZqYjws5YmP0VClyBpu_HM/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3124/optimized_AD_4nXcHO7Dwa2H2Jg0YzgjBYaz_TTMgBBm-4YSUdpNOMm4JPW1E-SQvLNLJhEp3hL4awTZs-JhUoR3cuL601ZNE8jsbnzyD0ShXRtU3Z8ohs1J5k2lqKgk8NrKW.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyNC9vcHRpbWl6ZWRfQURfNG5YY0hPN0R3YTJIMkpnMFl6Z2pCWWF6X1RUTWdCQm0tNFlTVWRwTk9NbTRKUFcxRS1TUXZMTkxKaEVwM2hMNGF3VFpzLUpoVW9SM2N1TDYwMVpORThqc2JuenlEMFNoWFJ0VTNaOG9oczFKNWsybHFLZ2s4TnJLVy5wbmciLCJwb3NpdGlvbiI6MTJ9)

You can build basic versions of this on your own computer using open source tools and libraries. 

The big secret behind all of these revolutionary image generators? They’re passing random noise into a model and telling it to find an image within, just as we asked children in our game to find plots in a random sequence of words.

## Moving beyond cats

Of course, there’s a bit more to it than that. We don’t just want cats, do we? We want the model to specifically find our described image in the noise. How can an AI system remove noisy pixels through an iterative process that moves closer to, say, _80s tv commercial showing a hippo fighting a pegasus_?

Let’s return to our story plot game. We can encourage the children to look at the input sentence with a given genre in mind. Rather than outputting _any_ plot they can dream up, their creative output will now be a bit more directed. If a child is told to find _a mystery that takes place in France_ in the nonsense sentence I referenced above—

_Gold scissor out headphone neat typewriter spinach._

—they may lean toward replacing _headphone_ with _France_ and _scissor_ with _stolen_—

_Gold stolen out France neat typewriter spinach_.

—and subsequently clean up a few other words—

_Gold stolen in France causes police investigation_.

They didn’t even need to replace the word gold, which fit nicely into the plot of our Parisian film noir.

In [my original article about LLMs](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktd29ya3MiLCJwb3NpdGlvbiI6MTN9), I described how machine learning systems can model non-mathematical concepts (such as food) in a mathematical way. Specifically, they are trained to cluster concepts sharing similar qualities on a graph called a vector space.

[![](https://proxy-prod.omnivore-image-cache.app/600x0,suHhh10degYuMshX_vMJwWwAVoQYgGuFhw9oUs_cQBw4/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3124/optimized_AD_4nXd07SYx4QzdohGh_fTsUFt_BGvc651XZzu86fyNs3yrSNsLBkXxfPX2XMiUgL7piUSqi5GtmwTLKZKkzfE_Ih0uOTl3oeXsf0mQFINax0zGuQaAy96uhpNo.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyNC9vcHRpbWl6ZWRfQURfNG5YZDA3U1l4NFF6ZG9oR2hfZlRzVUZ0X0JHdmM2NTFYWnp1ODZmeU5zM3lyU05zTEJrWHhmUFgyWE1pVWdMN3BpVVNxaTVHdG13VExLWktremZFX0loMHVPVGwzb2VYc2YwbVFGSU5heDB6R3VRYUF5OTZ1aHBOby5wbmciLCJwb3NpdGlvbiI6MTR9)

Just as an LLM can find the next word in its output by knowing roughly where in the vector space to look for it, we can instruct our image generating model to focus its de-noising in a particular region of the vector space. We do this by first using the LLM technology I previously explored to convert a text prompt into coordinates. This is akin to giving it a hint about what kind of underlying image to find, just as we nudged the child playing our story plot game toward a particular genre.

For example, if our image description details _italian food_, the image generator will know to look for output that would generally fit in this part of the vector space:

[![](https://proxy-prod.omnivore-image-cache.app/600x0,sHjg01QlO2WiKucKl6heyH8pwsJPfrRmLHxBSezpLiac/https://d24ovhgu8s7341.cloudfront.net/uploads/editor/posts/3124/optimized_AD_4nXeOGY4udA-oeo9TBlD2kOjQxEfV4PbFC0EiDvdTCQ5jE4iU8jV3dOKjQaH9NYWMMdCK-tWXZySofCu1dA4dXrAsrg7ufj0TPfEtWhoOXn699HSkuQO86PHs.png)](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZDI0b3ZoZ3U4czczNDEuY2xvdWRmcm9udC5uZXQvdXBsb2Fkcy9lZGl0b3IvcG9zdHMvMzEyNC9vcHRpbWl6ZWRfQURfNG5YZU9HWTR1ZEEtb2VvOVRCbEQya09qUXhFZlY0UGJGQzBFaUR2ZFRDUTVqRTRpVThqVjNkT0tqUWFIOU5ZV01NZENLLXRXWFp5U29mQ3UxZEE0ZFhyQXNyZzd1ZmowVFBmRXRXaG9PWG42OTlIU2t1UU84NlBIcy5wbmciLCJwb3NpdGlvbiI6MTV9)

The more specific the description, the smaller that target area becomes.

This also helps explain why image generators are non-deterministic (meaning no two inputs will ever yield identical outputs). First, the target zone in the vector space is an area, not a particular point. Second, the noise in which the model looks for that target Italian food is randomly generated each and every time.

## Finding the hidden pictures

As I had [previously written](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktd29ya3MiLCJwb3NpdGlvbiI6MTZ9), “Of course, there’s a bit more nuance. There’s some fancy math and complex computing. But the fundamentals truly are no different than those in the meal-planning example.”

The same is true here. These image generators are effectively doing what our story plot game accomplished. Given some noisy input and a gentle hint at what it should be looking for in them, very inventive outputs can be made.

I’m reminded of those [autostereograms](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0F1dG9zdGVyZW9ncmFtIiwicG9zaXRpb24iOjE3fQ==) I used to struggle with as a child—the rainbow-colored sprinkling of dots that revealed an image if you stared at them long enough. Who would have thought that those childhood games were previewing such a revolution in human ingenuity?

I was never good at finding the hidden picture in those autostereograms. Turns out, I didn’t need to be. I can now just teach a computer to do it for me instead.

---

**_Nir Zicherman_** _is a writer and entrepreneur. He was the co-founder of Anchor and the vice president of audiobooks at Spotify. He also writes the free weekly newsletter_ [_Z-Axis_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHA6Ly93d3cuemF4aXMucGFnZS8iLCJwb3NpdGlvbiI6MTh9)_._

_To read more essays like this, subscribe to_ [_Every_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vc3Vic2NyaWJlIiwicG9zaXRpb24iOjE5fQ==)_, and follow us on X at_ [_@every_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHA6Ly90d2l0dGVyLmNvbS9ldmVyeSIsInBvc2l0aW9uIjoyMH0=) _and on_ [_LinkedIn_](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vd3d3LmxpbmtlZGluLmNvbS9jb21wYW55L2V2ZXJ5aW5jLyIsInBvc2l0aW9uIjoyMX0=)_._

[Upgrade to paid to join 70,000+ readers of the best tech writing on the internet](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vc3Vic2NyaWJlIiwicG9zaXRpb24iOjIyfQ==)

#### What did you think of this post?

[ Amazing](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktaW1hZ2UtbW9kZWxzLXdvcmsvZmVlZGJhY2s%5FcmF0aW5nPWFtYXppbmdcdTAwMjZoYXNoPSVyZWNpcGllbnQuaGFzaCUiLCJwb3NpdGlvbiI6MjN9) [ Good](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktaW1hZ2UtbW9kZWxzLXdvcmsvZmVlZGJhY2s%5FcmF0aW5nPWdvb2RcdTAwMjZoYXNoPSVyZWNpcGllbnQuaGFzaCUiLCJwb3NpdGlvbiI6MjR9) [ Meh](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktaW1hZ2UtbW9kZWxzLXdvcmsvZmVlZGJhY2s%5FcmF0aW5nPW1laFx1MDAyNmhhc2g9JXJlY2lwaWVudC5oYXNoJSIsInBvc2l0aW9uIjoyNX0=) [ Bad](https://every.to/emails/click/6dc913eaf276f72ae60d9f5a14cfccd0ee00c1461a16b07f3deec67276660365/eyJzdWJqZWN0IjoiSG93IEFJIEltYWdlIE1vZGVscyBXb3JrIiwicG9zdF9pZCI6MzEyNCwicG9zdF90eXBlIjoicG9zdCIsInVybCI6Imh0dHBzOi8vZXZlcnkudG8vcC9ob3ctYWktaW1hZ2UtbW9kZWxzLXdvcmsvZmVlZGJhY2s%5FcmF0aW5nPWJhZFx1MDAyNmhhc2g9JXJlY2lwaWVudC5oYXNoJSIsInBvc2l0aW9uIjoyNn0=) 
