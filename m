From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 25 May 2020 14:51:38 +0200
Subject: [PATCH 12/21] drm/mcde: Use GEM CMA object functions
In-Reply-To: <CACRpkdaHuRHiNjisai2d-karW6y11M2qsPkx5Hn0sfc8T6B_qQ@mail.gmail.com>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-13-tzimmermann@suse.de>
 <CACRpkdaHuRHiNjisai2d-karW6y11M2qsPkx5Hn0sfc8T6B_qQ@mail.gmail.com>
Message-ID: <402b57b6-0827-2659-b676-dc633bf6c444@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 25.05.20 um 13:36 schrieb Linus Walleij:
> On Fri, May 22, 2020 at 3:52 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> 
>> The mcde driver uses the default implementation for CMA functions. The
>> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
>> All remaining operations are provided by CMA GEM object functions.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Could you boot-test with the patchset applied?

Best regards
Thomas

> 
> Yours,
> Linus Walleij
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N?rnberg, Germany
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Felix Imend?rffer

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200525/8231d91f/attachment-0001.sig>
