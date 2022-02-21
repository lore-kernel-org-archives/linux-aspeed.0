From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 21 Feb 2022 19:08:32 +0100
Subject: [PATCH v3] fsi: Aspeed: Fix a potential double free
In-Reply-To: <CACPK8XfxZRXtU0Bn+f0=B3CGUE8A8i9Ob_a9=2t=TzLc5a+75w@mail.gmail.com>
References: <2c123f8b0a40dc1a061fae982169fe030b4f47e6.1641765339.git.christophe.jaillet@wanadoo.fr>
 <CACPK8XfxZRXtU0Bn+f0=B3CGUE8A8i9Ob_a9=2t=TzLc5a+75w@mail.gmail.com>
Message-ID: <79bdf543-4882-360e-567f-493e84f09d6b@wanadoo.fr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le 21/02/2022 ? 10:24, Joel Stanley a ?crit?:
> Hi Christophe,
> 
> Thanks for the patch.
> 
> On Sun, 9 Jan 2022 at 21:56, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> A struct device can never be devm_alloc()'ed.
>> Here, it is embedded in "struct fsi_master", and "struct fsi_master" is
>> embedded in "struct fsi_master_aspeed".
>>
>> Since "struct device" is embedded, the data structure embedding it must be
>> released with the release function, as is already done here.
>>
>> So use kzalloc() instead of devm_kzalloc() when allocating "aspeed" and
>> update all error handling branches accordingly.
> 
> This looks like a problem with the design of the fsi master structure.
> It's a common pattern to devm_alloc the platform devices as they are
> probed, the fsi masters all embed a copy of struct fsi_master, which
> as you say embeds struct device.
> 
> Can we learn from other bus drivers (eg i2c?) how we should lay out
> these structures?
> 
Hi,
I won't do it myself.

This goes beyond my knowledge and without the possibility to test it, it 
would be just some random trial and error (as I did in the first broken 
version of this patch).

CJ
