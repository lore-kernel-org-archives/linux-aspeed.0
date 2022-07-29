From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 29 Jul 2022 09:39:19 +0200
Subject: [PATCH linux dev-5.15] soc: aspeed: abr: Add sysfs attrs for
 flash toggle
In-Reply-To: <62143648-8a90-4ff4-bfe1-f311b40cd50c@www.fastmail.com>
References: <20220501105644.355062-1-zhangjian.3032@bytedance.com>
 <62143648-8a90-4ff4-bfe1-f311b40cd50c@www.fastmail.com>
Message-ID: <32c4045d-7fce-5954-9710-4f6b0c6b0d2a@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On 7/29/22 04:37, Andrew Jeffery wrote:
> Hi Jian Zhang,
> 
> On Sun, 1 May 2022, at 20:26, Jian Zhang wrote:
>> Implement the flash toggle function in soc ast2600.
>> Add two sysfs attrs named "access_primary" and "access_backup"
> 
> If you're proposing this patch for upstream then it needs to be based on
> an upstream kernel tree, not the OpenBMC kernel tree. You also should
> not use e.g. `linux dev-5.15` in the patch subject prefix, as that would
> be inappropriate for an upstream patch.
> 
> As you're adding sysfs attributes you'll also need to add the
> corresponding ABI documentation.

Yes. I think we need to discuss the ABI/sysfs files a bit. I am not
sure we should toggle the sysfs files depending on the boot mode :
primary vs. alternate. We could have the same files always and return
EIO if some conditions are not met. Something like :

* boot mode : primary/alternate. Write changes the next boot.
* watchdog management

Also, there is no need to introduce a new include file with large
inline functions.

Thanks,

C.
