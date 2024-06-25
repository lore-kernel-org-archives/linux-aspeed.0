From: Markus Elfring <Markus.Elfring@web.de>
Date: Tue, 25 Jun 2024 14:50:25 +0200
Subject: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <2024062556-ladder-canister-1ab1@gregkh>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
 <2024062556-ladder-canister-1ab1@gregkh>
Message-ID: <ff2aaf0d-5456-43d1-af52-78986b3401f9@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>>> We should verify the bound of the array to assure that host
>>> may not manipulate the index to point past endpoint array.
>>
>> Why did you not choose an imperative wording for your change description?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94
>
> Markus, please stop reviewing USB patches.  This is not helpful at all,
> and causes new developers extra work for no reason at all.

How does this feedback fit to the linked information source?

Regards,
Markus
