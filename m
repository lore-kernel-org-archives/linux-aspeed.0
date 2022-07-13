From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Wed, 13 Jul 2022 00:24:45 -0700
Subject: [PATCH v7 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <45058512-0661-5d34-7faf-ddf3eb6142ec@linux.microsoft.com>
References: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
 <20220705020936.1751771-2-neal_liu@aspeedtech.com>
 <45058512-0661-5d34-7faf-ddf3eb6142ec@linux.microsoft.com>
Message-ID: <7041bf01-d91f-3149-e8ba-5db4ba59f9bb@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/12/2022 10:32 PM, Dhananjay Phadke wrote:
>> +static void aspeed_ahash_iV(struct aspeed_sham_reqctx *rctx)
>> +{
>> +??? if (rctx->flags & SHA_FLAGS_SHA1)
>> +??????? memcpy(rctx->digest, sha1_iv, 32);
>> +??? else if (rctx->flags & SHA_FLAGS_SHA224)
>> +??????? memcpy(rctx->digest, sha224_iv, 32);
>> +??? else if (rctx->flags & SHA_FLAGS_SHA256)
>> +??????? memcpy(rctx->digest, sha256_iv, 32);
>> +??? else if (rctx->flags & SHA_FLAGS_SHA384)
>> +??????? memcpy(rctx->digest, sha384_iv, 64);
>> +??? else if (rctx->flags & SHA_FLAGS_SHA512)
>> +??????? memcpy(rctx->digest, sha512_iv, 64);
>> +??? else if (rctx->flags & SHA_FLAGS_SHA512_224)
>> +??????? memcpy(rctx->digest, sha512_224_iv, 64);
>> +??? else if (rctx->flags & SHA_FLAGS_SHA512_256)
>> +??????? memcpy(rctx->digest, sha512_256_iv, 64);
>> +}
> 
> Can use the "digsize" from reqctx to memcpy() instead lots of if..else
> conditionals for every request?

Sorry, meant pre-initialized ivsize not digsize, which could be
in alg wrapper structure (aspeed_hace_alg).

Thanks,
Dhananjay
