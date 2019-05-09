From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Thu, 9 May 2019 10:19:49 -0500
Subject: [PATCH 1/7] media: aspeed: fix a kernel warning on clk control
In-Reply-To: <b682cc6a480f2b8a5e14c5c001fa1927467d4e18.camel@kernel.crashing.org>
References: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
 <20190502191317.29698-2-jae.hyun.yoo@linux.intel.com>
 <1ec7397cb164b40877839bbc90f79b5942675fdb.camel@kernel.crashing.org>
 <6e93467e-1556-3cfd-b15c-c12b6907f526@linux.intel.com>
 <3b4269d829467870f0b6adac18089b93114fcd3c.camel@kernel.crashing.org>
 <3786afed-c34d-e3f0-4cd5-620185807091@linux.intel.com>
 <b682cc6a480f2b8a5e14c5c001fa1927467d4e18.camel@kernel.crashing.org>
Message-ID: <5a155296-b1a7-4120-3ead-1b0d21772f1a@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/8/19 9:16 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2019-05-08 at 18:19 -0700, Jae Hyun Yoo wrote:
>> I changed that from a bool because the maintainer of this code, Eddie
>> doesn't like adding of an additional flag. I'll change it back with
>> codes in the first submit:
>> https://www.spinics.net/lists/linux-media/msg148955.html
>>
>> Eddie,
>> Please let me know if you have any objection on that.


Thats fine with me. I merely thought it was more conventional to use 
flags rather than bools, but I may be mistaken.

Thanks!

Eddie


> Ok, so random flags ... ugh.
>
> Well, you can approach it either way. Have them all be bitops or all be
> bool.
>
> The tricky thing however is that if they are bitops you need to ensure
> that they are *all* manipulated under the same lock. If not you have to
> use the atomic bitops variants.
>
> The reason I don't like that is that experience shows that most uses of
> such atomic variants in drivers usually are failed attempts at papering
> over broken locking.
>
> If everything is covered by a lock, then using the non-atomic versions
> is more efficient, but so is using bool (optionally with :1 bitfield
> qualifiers to avoid wasting memory), which from a pure C language
> perspective I think is more expressive of what you are doing and more
> readable.
>
> Cheers,
> Ben.
>

