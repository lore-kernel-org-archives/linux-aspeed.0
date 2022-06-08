From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Wed, 8 Jun 2022 12:33:41 -0700
Subject: [PATCH 5/5] crypto: aspeed: add HACE crypto driver
In-Reply-To: <20220601054204.1522976-6-neal_liu@aspeedtech.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-6-neal_liu@aspeedtech.com>
Message-ID: <6f9e1481-db9c-cd5f-c38d-bdcd3040315f@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/6/2022 8:43 PM, Neal Liu wrote:
>>> +struct aspeed_hace_alg {
>>> +	struct aspeed_hace_dev		*hace_dev;
>>> +	union {
>>> +		struct skcipher_alg	skcipher;
>>> +		struct aead_alg		aead;
>>> +		struct ahash_alg	ahash;
>>> +		struct kpp_alg		kpp;
>>> +		struct akcipher_alg	akcipher;
>>
>> Your patch dont do any kpp or akcipher (and aead/skcipher also).
>> Please drop this.
>
> I miss this part, I'll revise it in next patch, thanks.

Hi Neal,

Are you planning to submit aead separately? HW programming interface
for aes-gcm is almost same as other aes modes except extra regs/fields 
for tag etc.


Thanks,
Dhananjay


