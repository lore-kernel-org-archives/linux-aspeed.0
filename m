Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E7606A31D
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lF78wMsq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFd7h3bKrz30FB;
	Thu, 29 Oct 2026 19:44:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793263456;
	cv=none; b=mHba3aSQuoxsRPo86vt2dXY6eAPsoB/ou2c6ECicGv646m2rdw7zGLeFc9Nw8m9DoxO1KfSzn+zIi7DciJALIKrYEjgGz2mgkX6xMrN2WsrimkLYy3jJnKDtMG0tGSuH0fYD6fRmm7mxJWvNEXKqA6/zaHlK3DJiQ1sBjHp/QpxxA0KEfOVqLSUGEDCYciBAv++G/QL6wf1xdqIc8I2I59kT1/XDwMILYwRpp/dKTp+EnZWjMUQBn53vbwoEyQ8LMLoxuV7uRKjwu6tQNhgqd627NdqxaEORUch9ZwQYsgJTx0BPigRYoJZ8RX+uTan1wZ1kE8aa3unf/2mikvgvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793263456; c=relaxed/relaxed;
	bh=YDl9p7g5quENVJzD97vvD5OqlYe1ysXU7bQyzl1X/uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wn3slc85gUGffz95RUxBftGOZFG4jEyYfbZdry5HRKRqMGAOEmF6l6ocYCtAynq3J5p3DMAMb75/7omGmHCkCILXEuIe78B3Bu8m5NKkj4UCozjau0uORa6SF4pFXakfhMUNPzN0W2D51uKhqHw/bcFtNVHTA/hzNlf0zEJaP5j82K30FzQNaGf04ywNYSyTVXtJJXLzPh6x2zhFpHHcmzcnY6P2KL3C3ZrzY0EJU59llrxrSJeycVcjr6Sydoj/SHRxo7fJWRGbPbzFoLaBoJCzwT37Q/uqbWVYGBIKwV3AT6gO5mGbtanWBIwoppVE4dvVicAzZuHdt2tRU8WK1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lF78wMsq; dkim-atps=neutral; spf=pass (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lF78wMsq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFd7d2LHmz2ylj
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 19:44:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793263454; x=1824799454;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WP/QAZ7Uc8hCjUk9W10FsuMb7rLn58PCckd869LjBFA=;
  b=lF78wMsquxStQqdH4hWVsIglelmwDPIBPk50emunrsAdpU0R3Y/Bmbg4
   oRacn4RMhUukWGl7fZP+NVnLg3VxFQRtx0puGlx133r9pwgRh6NSR4tzs
   fHudx3/BwHWE4HJjDTKFBKBHxA7eXSmGKVln2qKrF6aWN1Oss27S8Gbe2
   UVW97ZCy5DZdCrLFh1lrh9y9zfu3GDRPpkCXHiUDiL7jQk1zxalwFEQYO
   BsyFYhxhNjEBbs+uw4zbuYOqin+jWLQUkhCwyTwDFrtlGDwirknrc8ibT
   A4AckA9RZ082CVXjRHpKkrGF+J4558u4ccGYyb7GVa4vyy2e7R3sKWlWz
   g==;
X-CSE-ConnectionGUID: Fr5q3H9KTPOBORo5VkZuxw==
X-CSE-MsgGUID: XIB65IRRT+eKvOchZIZO7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2002480"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2002480"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:44:06 -0700
X-CSE-ConnectionGUID: oDqzyd5cQ0OZV3ZmvaMS7A==
X-CSE-MsgGUID: gVbT5JW4Somf8pxelwKQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5411378"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:43:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6n?=
 =?utf-8?Q?ig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy
 Tsai <billy_tsai@aspeedtech.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
In-Reply-To: <auHf-pdvGkPibgTp@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1793027261.git.d@ilvokhin.com>
 <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
 <auHf-pdvGkPibgTp@zenone.zhora.eu>
Date: Thu, 29 Oct 2026 10:43:56 +0200
Message-ID: <b3045bc3ae77ef78a1f479448a5dc780d89bf38d@intel.com>
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
Content-Type: text/plain
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026, Andi Shyti <andi.shyti@kernel.org> wrote:
> Hi Dmitry,
>
> On Wed, Oct 28, 2026 at 08:19:44AM +0000, Dmitry Ilvokhin wrote:
>> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
>> nonnull") added the macro __nonnull_args() to wrap raw compiler
>> attribute.
>> 
>> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
>> nonnull attribute usage across the tree and keep the attribute's quirks
>> in one place rather than open-coded at every call site.
>> 
>> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Pushed this patch to drm-intel-next, thanks for the patch and review.

BR,
Jani.


-- 
Jani Nikula, Intel

