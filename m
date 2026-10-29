Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21183606A322
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TPGjIq84
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFlHj1w9gz30RN;
	Fri, 30 Oct 2026 00:21:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793280097;
	cv=none; b=byAw/q2Gzv2/MhLFt+SLl5oUq1W/x366iViGxM4NofEAJdwP3ws1nJX+IfoGjHDp7bzbsqn5/kGhZ3vUm5SCEWeSrox5nGEWtGZfOlXN7QudWzI0/C27ui0t26EP/bhV0eoNb9I1C/U9QGiTxe+8jieFYjMbic08pIgJ44qnCtT8/1P1FlhDg4Cevq1Z4B6wTh/ObyLV04fqd/+h8VlJOYQlwruMFvyATRSfWl3TmGPg6pPsNb3Yymv+EFDONsk57pl2ow/WD20oOYryO/oR/5yVv/evLv/w9mWyAOXjUICmXOK0MGYOz8W9O/Oxkg/T8/VKtKBrzDj+JGFC3Xk57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793280097; c=relaxed/relaxed;
	bh=SdAws15E4boPyFwiZCIHuT2z7R3eozeBP3yjVNgMrMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxI7MPUwRJnVdFGl+9+vtjoMsCgRgp0fawAs/2y1Y/ailu7j3MHnJtoKUGGV0rPABGY9GXA3kUfU2+E0zrczG2B2Ese1qOOuh2zXzvqf0haeNiOoJSDvkFGufmHp1nOFpXoMlFykaSMhj9JEJCaJYMDOZtuw2Ri9DCrWAbJjGNOyPxlZx6BOc4j+v2j9CTvk9VK8ltrrO+N+oGbjpNT6+7YFM2D56ODI04HLGCBVIGElO+n+Ht/iS0naqy28wR0UBZG3FCf0rx9Pfm3op0+f1sOebFdk5I8d55ogrowvAlLG+Ry872mQFVoIwz7qpsHi72icTZ2SyiaugOEWXMkAiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TPGjIq84; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TPGjIq84;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFlHf2FRZz30FB
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:21:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793280095; x=1824816095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tkpV40hGhO5XeSgRXjpBId5i/GBz5co0mYtfaR2uPHc=;
  b=TPGjIq84G3VIr8PyF9XcHA6uz9ON68ipdVtJO7jSdJJ0o03FzqEZTqHa
   Zv2mqiTgqAZT6PIb4+cCa2FEqduJAd8tAEzxC7BzqJDWsGocbF2dBl1Ab
   Ag39TPiAl9bw61C952QmmVJ9rqnfZwVcC7D897l2I6S/TtX75hbSyOJFL
   LqKU95dePVernYxTQFgtD/xPwNTtZXMeXVKzCllZN3apW6mbFYzQDd3uA
   SK5hizrlNO0U1bj+gd+LcVNsDpNN/7nZ6jYQAhbZLgwFeLCpgjNoaGXDh
   kTn3hBKUvHHyilJ6pJ7RrCL1gFnsMWqidrZdCO/sPBtD1QNovcmCtL1xA
   w==;
X-CSE-ConnectionGUID: GtGX2ZPjTZy0Fzza3jZepA==
X-CSE-MsgGUID: HlSVcjFjSpWD3zeGDvJYNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1899930"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1899930"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:21:26 -0700
X-CSE-ConnectionGUID: lcHCQ8oTT4+RWbV1aJm5jw==
X-CSE-MsgGUID: gd6Ro2tCRA6pOUXdfheN3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5690610"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:21:17 -0700
Date: Thu, 29 Oct 2026 15:21:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
Message-ID: <auNIS5n2aUD9t7yB@ashevche-desk.local>
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
 <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 02:00:28PM +0100, Miguel Ojeda wrote:
> On Thu, Oct 29, 2026 at 8:32 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Should gem.h now include <linux/compiler_attributes.h> ?
> 
> No, it should be included for you (unless you are doing something
> custom with the compiler flags etc.).

Usually it comes to the mere drivers via types.h, in rare cases (usually some
more generic library headers, we do better granularity as it affects the almost
entire kernel. Just double check that types.h is explicitly included.

-- 
With Best Regards,
Andy Shevchenko



