From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 14 Feb 2024 11:34:31 +0000
Subject: =?big5?B?pl7C0DogW1BBVENIXSBBZGQgZVNQSSBkZXZpY2UgZHJpdmVyIChmbGFzaCBjaGFu?=
 =?big5?Q?nel)?=
In-Reply-To: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
Message-ID: <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Most of the implementation originates from Aspeed.
Please preserve the Aspeed copyright before adding the IBM one.

For removing IOCTL and adopting MTD interface, I thought we have already discussed this in public and in private many times.
The MTD interface acting as a master to control flash can NOT serve SAFS (a.k.a. eDAF), which is the major use case of eSPI flash channel on numerous Intel/AMD platforms.

Is SAFS not necessary on your platform?
If so, please consider to rename the driver to espi-mafs to be more specific. As the driver does not support SAFS actually.

I am not saying IOCTL is the best solution.
If there is a more user-firendly interface, I would be glad to revise the implementation as well.
But, the truth is that most existing kernel subsystems act in the master roles, which makes them hard to be applied on eSPI slave.
And this is also well explained in the previous mailing thread.

We appreciate that you are willing to help on the open source contribution. 
However, please co-work with Aspeed before submitting drivers of Aspeed HW.
Otherwise, a misleading driver on the community are going to bring tons of customer issues to Aspeed.

Thanks,
Chiawei

> Sent by: Manojkiran Eda <manojkiran.eda@gmail.com>
> ---
> Hello everyone,
> 
> I'm presenting a revised version of the eSPI device driver patch series found at the following link:
> 
> https://lore.kernel.org/openbmc/20220516005412.4844-1-chiawei_wang at aspeedtech.com/ 
> 
> This update addresses the issues identified during the review process.
> 
> While the previous patch series attempted to incorporate support for all four different channels of eSPI,
> this new series focuses on upstreaming the flash channel initially, ensuring that all review comments are
> duly addressed, before progressing further.
> 
> Results:

> Successfully conducted a flash update via eSPI.

> Note:

> This marks my inaugural endeavor in contributing code to the kernel subsystem. I kindly request reviewers
> to incorporate as many details as possible in the review comments.
