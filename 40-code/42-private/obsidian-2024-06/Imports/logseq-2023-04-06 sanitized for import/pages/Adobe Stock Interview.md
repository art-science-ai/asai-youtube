---
title: Adobe Stock Interview
---

- [[Adobe Stock Interview]] pre-work for [[Shambhavi]]  #Projects #[[Projects]]-Work-misc #2020-W40
	 - Adobe Stock Customer interview questions
id:: ce060182-68c9-4ee8-a230-e82b0fc66619
		 - General
			 - What's your role and what do you use stock photos for? 

			 - How do you go about finding the right stock photo for your needs? Give examples.

		 - Copy space
			 - Intro: (Copy space is when an image has area on which you can overlay text for a marketing campaign)

			 - Use cases
				 - What do you use copy-space images for? 

			 - Usage patterns
				 - Can you walk me through your process of finding the right copy-space image?

				 - What search terms do you enter? 

				 - How do you sort or filter the search results you get?

				 - How do you choose the right image from the sorted and filtered results?

				 - What dimensions of the image are important to you? E.g. color, size, contrast

				 - Within each of those dimensions, what features are important to you? E.g. within color, do you care about light vs. dark? Or blue vs. red? 

			 - Pain points
				 - What are your pain points with this process?

				 - What do you wish you could do that you can't do?

				 - How do you think this could be improved?

				 - Are there any filters you want? Check-boxes?

				 - What do you wish you could do that you can’t do today?

			 - Example exercise

		 - Cheesy images
			 - Do you sometimes find stock images to be cheesy or inauthentic? 

			 - Is this a problem? Why?

			 - What does cheesy or inauthentic mean to you?

			 - What are some characteristics?

			 - How would you explain it?

	 - Deck
		 - Introduction and methodology
			 - Define the labels
				 - Qualitative customer research (e.g. interviews) to define the labels

				 - Unsupervised image classification and clustering

				 - Quantitative customer research (e.g. surveys) to validate the labels

			 - Perform the labeling
				 - Methods of labeling
					 - Manual labeling by subject matter experts

					 - Crowdsourcing labels (e.g. in-product feature)

					 - Need consensus among several labelers

					 - Assistive labeling; https://aws.amazon.com/sagemaker/groundtruth/

			 - Train a classifier using the labeled data

			 - Loop: Active learning (ML) (system can indicate what training data it would benefit from most)

		 - Classifying copy space images
			 - Customer research

			 - Labels
				 - Background: light, dark, mixed

				 - Size of copy-space: small, med, large

				 - Shape

				 - Natural vs unnatural

			 - Validation
				 - Mock-ups

		 - Classifying cheesy images
			 - We already know the label and the dimension. Skip right to the validation phase.

			 - Understand the definition of cheesy.

			 - Questions
				 - What does a cheesy image mean to you?

			 - Ref
				 - https://www.wiremedia.net/cheesy-stock-photos-stop/
					 - **Eye Contact:** A lot of stock photos picture groups of people that are all posed and looking straight at the camera. These look cheesy and forced and are a dead giveaway that it’s not a group of real people.

					 - **Too posed:** People photographed in postures or positions that just aren’t normal are a dead giveaway. The smiling leader looking at the camera with the team in soft focus in the back hard at work is a good example.

					 - **Word Flocks:** Photos of a lot of related words clustered together in different sizes and patterns are some of the most prevalent stock photos. They aren’t creative and they are honestly kind of hard to look at / interpret.

					 - **Obligatory Handshake:** The handshake is one of the most cliche images out there. They are usually people in business attire shaking hands with a blurry backdrop of an office or building. These photos don’t look natural and don’t say anything about the material you are presenting.

					 - **Studio Lighting:** Photos with bright studio-style lighting that look like they have been taken against a backdrop also look cheesy and posed. Avoid these in favor of real photos that look like a great photographer snapped them but not in a stylized studio setting.

		 - Next steps

	 - Questions for Shambhavi - skip this; not needed.
		 - Copy space

		 - Cheesy
			 - The assignment says "think about what taxonomies emerge for you to distinguish the cheesy from the non-cheesy". However, since there are no labels to distinguish cheesy images from non-cheesy images, I am assuming that you want me to rely on my own intuition to make this distinction. Is this correct?

	 - Prompt
		 - Pre-Work for Shambhavi Interview (estimated time, 1-2 hours total)

		 - A large part of this role will be creating labeled data sets by coming up with the right groupings of content, and being able to explain these groupings to human judges so that they can accurately label assets for us. You will go through two exercises in person with Shambhavi to evaluate how you approach this process. The following pre-work will be important to prepare for the interview:

		 - · Copy space is when an image has area on which you can overlay text for a marketing campaign (look at digital or print advertisements to find examples of this). Imagine you are trying to create a labeled data set for a copy space classifier. This library contains some sample images that have copy space. Sit with this content and think about what groupings emerge for the types of copy space these images represent, and then separate the images in this library into those groupings (you can do this via Power Point, using Libraries, or another visual tool). Remember that the groupings should be independent of the subject of the image. Feel free to look for more examples of images with copy space if you would like. https://assets.adobe.com/public/c83abf6f-74c3-42ee-7871-2cbb558d2987

		 - · Imagine you have been asked to create a "Cheesy" classifier. Cheesy image are often described by customers as images that look inauthentic, artificial or staged. This library contains a random sampling of images from our collection (that are not necessarily Cheesy). Sit with this content and think about what taxonomies emerge for you to distinguish the cheesy from the non-cheesy, and then separate the images in this library into those groupings (you can do this using Libraries, via Power Point, or another visual tool). Feel free to look for more examples of images if you would like. https://assets.adobe.com/public/a8c9c307-83ea-48dd-4816-59d1d0c6e43b

		 - You will need an Adobe ID so that you can view/engage with the linked libraries (TIP: click the “Copy to your work” link in the library to create a copy on your Adobe account that you can view on Stock). You do not have to send this in ahead of our conversation, but will screen share your groupings so we can discuss together.

- [[Behavioral Interview stories]]

- 
