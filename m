Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969760A3809
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MR+cqIhP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV70b0Jskz2xSl;
	Thu, 19 Nov 2026 03:51:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795020686;
	cv=none; b=Gm8+bsW//6rP303rjlXpuGiUI09S6ugIrtjSrXoNk7FCn/Z7Efju3umSIZWdxhJd+lKRd4rBBKAOToVvdh1a82MqMN61GxtBI28Hnb/P6ABT+OTRMZ4js+/urzj6/hPE4dsgxgMLjTJAfzytVt9YXmQIyZKu6YVrTy7WlZHZf1T9LQvvA5/a5ZP7ODIRDUu4DsTIIapYrqBET5q4szB98J0d+9/BB3Y78ag5DQhyKJ8zbQEIVT9c6YGSwWayFCXbFwbDvNtjqktd7RbUZ5V4ltsMozYsYX/aoYLjQxZ5Y6OxxItW6i2wpXPdcid+yiMgH2H6YBKS8gURh5YeFATL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795020686; c=relaxed/relaxed;
	bh=/cUldU1e2XAI/ZxV0Ch4uDE5FUyxfirjC3SAjGA4JrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHMFSqld/98cwzWlVYSunl7nFbsjILmWtXajvHl9J/qYCelBhG/ZV0YzQnfQ3CkXLMp3DIoyUq4a490CdaXeOfjBXB7Vd6ytu/0/RUNPv7ULaI/FjlPTmAiyk6Ph5SwceMUds9fXwbHj/LFNHzTdie4gUJBd1RhJ0cM6CV1F+twPX3TzgWTWhK2FPqLiNyFBkE4kohsfFkb+BtsbXWgXKG+u4WJVc2cS6puWapcvy/1sR4MfOGQxO4kKJaVEqLZiXRxox79sRLbgn/NQNE1DpqnbnKAkss+1+4aL1KiyPpbDRdpBSH987uBzRCZ9NFlA6A2P4ulKBSlI75AZKasXOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MR+cqIhP; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MR+cqIhP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV70X1X8Pz2xMt
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Nov 2026 03:51:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795020684; x=1826556684;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ajDnh0zw+64dcFPrEUfvS5sWfWZYQWJZbcQwO+AcVNs=;
  b=MR+cqIhPvcv9ENCgwgQp+w136q5E5ZrF8Gr2k1oHAStv3nmORyTsYhIx
   dmB4ZhZA3RiHYKpQT9jX+b9oATSksOCgpupoAqcVsB6qiO987bQJCdp2+
   RvFFOvAEPIQYhayUD6l7g0YziH62AmA1xbRHANVmNBNhDrsm/sT62LZ+1
   los1cgShguo+tNWVMW5YTqnOFCf+4MI3IP5FktQFdubs9TNg5rw1x2kLt
   aT7NzqI44nrUxjFq72/wodsiZN9iPoQtNnoJphJCdqCJTFjpYQLcPxwr0
   +ppilDS7nihsZEZvDQnpPZxEFDxvsIXNunqPfO47sNuWDzZSwx77IZqCQ
   Q==;
X-CSE-ConnectionGUID: xqtIaZagRpGCd/Kv1tkEMg==
X-CSE-MsgGUID: CTgc0CVgRdKQViZfkvXYaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3699704"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3699704"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:50:31 -0800
X-CSE-ConnectionGUID: k/DCmaX/Qp2q9S20vakyDw==
X-CSE-MsgGUID: YVFQiz1BSVmcIhLrCJbvrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9985477"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:50:21 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sasha
 Finkelstein <k@chaosmail.tech>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org,
 asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-riscv@lists.infradead.org, etnaviv@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imagination@lists.freedesktop.org,
 linux-mips@vger.kernel.org, lima@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 9/9] drm: Unify coding style for *_device_id arrays
In-Reply-To: <av2rKJQ0AKU9CFZI@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1795002467.git.ukleinek@kernel.org>
 <a2d5ce256b8ec150de4a6494c177b19693a33222.1795002467.git.ukleinek@kernel.org>
 <7692c160e418e7ad0528739fcc879b11fbac8ab0@intel.com>
 <av2rKJQ0AKU9CFZI@monoceros>
Date: Wed, 18 Nov 2026 18:50:19 +0200
Message-ID: <8ebe3b7219ffd963a498cccbcfe6cefc92717f0c@intel.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> w=
rote:
> Hello Jani,
>
> On Wed, Nov 18, 2026 at 03:27:40PM +0200, Jani Nikula wrote:
>> > [...]
>> >  drivers/gpu/ipu-v3/ipu-common.c               |   8 +-
>> >  drivers/gpu/ipu-v3/ipu-pre.c                  |   4 +-
>> >  drivers/gpu/ipu-v3/ipu-prg.c                  |   4 +-
>> >  254 files changed, 1155 insertions(+), 940 deletions(-)
>>=20
>> How do you expect a patch of this size be merged?
>
> Using b4 am :-) Honestly, in the cover letter I wrote about an immutable
> branch and offered to rebase to 7.4-rc1. When trying to apply this
> series on top ov 7.4-rc1 there are only 6 conflicts (1x modify/delete
> and 5x content); these are all not so hard to resolve (and even dropping
> the respective hunks (i.e. resolving using `git checkout HEAD`) is fine
> for me.)
>
>> > diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i9=
15_pci.c
>> > index 84a7dc6ab5db..faceb3de4fa3 100644
>> > --- a/drivers/gpu/drm/i915/i915_pci.c
>> > +++ b/drivers/gpu/drm/i915/i915_pci.c
>> > @@ -870,7 +870,7 @@ static const struct pci_device_id pciidlist[] =3D {
>> >  	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
>> >  	INTEL_ARL_IDS(INTEL_VGA_DEVICE, &mtl_info),
>> >  	INTEL_MTL_IDS(INTEL_VGA_DEVICE, &mtl_info),
>> > -	{}
>> > +	{ }
>>=20
>> Personally, I would *always* use {} instead of { }, and would rather not
>> change.
>>=20
>> Across the tree, {} is slightly more common than { }. IMO changing them
>> is pointless churn.
>
> It depends on how you count. My statistic looks as follows (on top of
> next-20261117):
>
> 	$ git grep -l device_id | xargs -n 1 perl -g -n -e 'print "$1\n" if m/de=
vice_id\s*[a-zA-Z_0-9]*\[\]\s*=3D\s*{(?:\s*{[^}]*},\s*({\s*}))/' | sort | u=
niq -c
> 	      2 	}
> 	      2 {
> 	      6 {  }
> 	   2598 { }
> 	   1262 {}
>
> So over all *_device_id { } is more common by a factor of > 2. This
> series fixes one {  } and reduces the number of {} by 37. For only
> pci_device_id it's:
>
> 	$ git grep -l pci_device_id | xargs -n 1 perl -g -n -e 'print "$1\n" if =
m/pci_device_id\s*[a-zA-Z_0-9]*\[\]\s*=3D\s*{(?:\s*{[^}]*},\s*({\s*}))/' | =
sort | uniq -c
> 	    159 { }
> 	     32 {}
>
> Without the context of an array initializer there are many empty
> code blocks (function bodys or `do {} while (0)`), empty dt nodes, and
> {} in Rust code, which IMHO have to be considered off-topic for this
> statistic.

I realize my phrasing was careless.

My point was not so much about one being more common than the other, but
rather that there are *thousands* of instances of both, specifically as
C compound literals with empty initializer list. I think it's pointless
to convert one to other, regardless of whether you're adding or removing
a space.

I mentioned my preference, because if I were to go on a style fixing
spree, I'd go the other direction. But I think that too would be
pointless.

I suggest to just accept either.


BR,
Jani.


--=20
Jani Nikula, Intel

