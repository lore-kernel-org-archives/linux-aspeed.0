From: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 30 May 2024 09:42:27 -0000
Subject: [v2 04/20] pinctrl: starfive: Use scope based of_node_put()
 cleanups
In-Reply-To: <DU0PR04MB9417AEB942C1EDC053B3894288F32@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240504-pinctrl-cleanup-v2-4-26c5f2dc1181@nxp.com>
 <96beb071-ec2c-475f-8fa2-d519a1b1dc28@web.de>
 <DU0PR04MB9417AEB942C1EDC053B3894288F32@DU0PR04MB9417.eurprd04.prod.outlook.com>
Message-ID: <5a2f7786-bb02-441a-a60e-a7a548a30a79@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>> 1. Exception handling is repeated a few times also according to memory
>> allocation failures.
>>    How do you think about to use a corresponding label like "e_nomem"
>>    so that another bit of duplicate source code can be avoided?
>
> I have no plan to rework this series for non-accepted patches. If you have
> interest and time, feel free to take it.
>>
>> https://wiki.se/
>> i.cmu.edu%2Fconfluence%2Fdisplay%2Fc%2FMEM12-
>> C.%2BConsider%2Busing%2Ba%2Bgoto%2Bchain%2Bwhen%2Bleaving%2Ba%
>> 2Bfunction%2Bon%2Berror%2Bwhen%2Busing%2Band%2Breleasing%2Bresou
>> rces&data=05%7C02%7Cpeng.fan%40nxp.com%7C293bafdf40524fa4655b08
>> dc7e58f6b2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63852
>> 4167804502915%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
>> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata
>> =Kb5cz6sVxW1TNfQ8MM2F6YLIIztyjvW4wULEJLYKRM8%3D&reserved=0

I became curious how the change acceptance will evolve further
also according to such a code transformation possibility.


>> 2. Will development interests grow for the usage of a statement like
>> "guard(mutex)(&sfp->mutex);"?
>
> I have no plan on this.

Other contributors might get attracted by corresponding design adjustments.
https://elixir.bootlin.com/linux/v6.10-rc1/source/include/linux/cleanup.h#L124

See also:
Looking at guard usage (with SmPL)
https://lore.kernel.org/cocci/2dc6a1c7-79bf-42e3-95cc-599a1e154f57 at web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-05/msg00090.html

Regards,
Markus
