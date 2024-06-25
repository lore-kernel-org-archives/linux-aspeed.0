From: Markus Elfring <Markus.Elfring@web.de>
Date: Tue, 25 Jun 2024 17:20:07 +0200
Subject: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <2024062532-strep-president-44d7@gregkh>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
 <2024062556-ladder-canister-1ab1@gregkh>
 <ff2aaf0d-5456-43d1-af52-78986b3401f9@web.de>
 <2024062532-strep-president-44d7@gregkh>
Message-ID: <5fa430f5-3e18-4c20-93d4-6733afd6bdcf@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>>>>> We should verify the bound of the array to assure that host
>>>>> may not manipulate the index to point past endpoint array.
>>>>
>>>> Why did you not choose an imperative wording for your change description?
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94
>>>
>>> Markus, please stop reviewing USB patches.  This is not helpful at all,
>>> and causes new developers extra work for no reason at all.
>>
>> How does this feedback fit to the linked information source?
>
> That is not what I wrote.

You indicated concerns according to patch review processes,
didn't you?

See also:
* Patch submission notes
  https://elixir.bootlin.com/linux/v6.10-rc5/source/Documentation/process/maintainer-tip.rst#L100

* Contributor Covenant Code of Conduct
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/code-of-conduct.rst?h=v6.10-rc5#n3


> I wrote, "Please stop reviewing USB patches."
>
> Please stop now.

I might be going to influence evolution of this software area in other ways
under other circumstances.

Regards,
Markus
