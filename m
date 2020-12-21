From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon, 21 Dec 2020 12:31:46 -0800
Subject: [PATCH 2/2] media: aspeed: fix clock handling logic
In-Reply-To: <160842289176.1580929.13125223155803124427@swboyd.mtv.corp.google.com>
References: <20201207164240.15436-1-jae.hyun.yoo@linux.intel.com>
 <20201207164240.15436-3-jae.hyun.yoo@linux.intel.com>
 <CACPK8Xd3dz1WLGNGqMiAZxhMEeGHbkPtvO2rYQ36Kbj=Uvy-jA@mail.gmail.com>
 <d3faea9e-e7d6-eba0-a6b2-c30bc9b6e147@linux.intel.com>
 <160820199393.1580929.9806429719720580479@swboyd.mtv.corp.google.com>
 <d3f2d76c-40d9-b167-7002-5a25ec81c73a@linux.intel.com>
 <160842289176.1580929.13125223155803124427@swboyd.mtv.corp.google.com>
Message-ID: <4b67f62c-012b-d6e9-cf98-1093175793c4@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/19/2020 4:08 PM, Stephen Boyd wrote:
> Quoting Jae Hyun Yoo (2020-12-17 11:54:15)
>> On 12/17/2020 2:46 AM, Stephen Boyd wrote:
>>> Quoting Jae Hyun Yoo (2020-12-08 09:16:29)
>>> So should the two patches be squashed together and go through the
>>> media tree?
>>>
>>
>> The first patch should go through clk tree, and the second one (this
>> patch) should go through media tree. Both patches should be applied at
>> the same time. Should I squash them in this case?
> 
> If one depends on the other, and having the first one breaks something
> unless the second one is applied, then yes they should be squashed
> together.
> 

Okay. Will send a squashed commit as v2.

Thanks,
Jae
