Return-Path: <linux-aspeed+bounces-5111-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D08CA5FD4
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 09:24:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx3Jz06s5z2yNj;
	Fri, 02 Oct 2026 19:24:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790933090;
	cv=none; b=aPasKsyDWVyxsWSCJN4KM1/SQAkJov07xiLobcxSqdcXS0s/1dWvPytGQ1Tm8f9NiS9LDwyNwMSaJnQ07852mQatMSbJ3XtuVUCZBGKopVdEmKe6GE3jizoMAzz+imSSFoAEUqY7z8yJPdOStkAo+KXykqowlUvS6e4ofewIpJs5NOMxUpW+WUz/yIyuEJpJhOA1NlTqRTehUFh3x0zQkALeynF4RMlfos2KlyROe8hjxPoO4wOfJlBCE5ddJBOfwe5Vr7HFPJ4Y2FkfX7izUGfI9hcXpz8+3AZTIdr69NEHuIS8I9k3p2sfAaC8cM67dKpwuYdX2iNK4eCzHGPLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790933090; c=relaxed/relaxed;
	bh=VsDqxcg/n5wbI1PAbxInDdXphWsg7g/jnw1r6gwNoro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InRfB2bOho09KytRNoghnh2n7453AgtPgQMPdtfv4t+1+aJGaPVTdhPrVlWz/QGN5HA8JKQPABrH3CC8zqQiYgu85s2P3A3LaCgemLa3OeRps2yBDdIpkUF9ABcd8tHn2QdaJ4oSMNAJvBPTzmwHk542FN2mIHRML1kcvjz/Ep7MK253lpcMppzD748bKANiGRhwM/NfAqghPKvl0tO4HwVNxRrLiXrnG/vcZdwlP4FVAO30aFv0jS7XxM6A+62QzwMuLs/qFl0SMMthLjNeyi2639QwMDwdC4iXwhptWZ5hn/QMKvYFI55rorBMB5Zu6LwxP2L2/9r1dZcE6ilQQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R0tajatI; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R0tajatI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Fri, 02 Oct 2026 19:24:48 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx3Jw1SbSz2yDs
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 19:24:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790933089; x=1822469089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmuLiQbd8QxL0tTNDCxKS9p6kykYRAuOi0Tb34sjbfc=;
  b=R0tajatIhPjMEKwWkNQkxaY3wrYC1uCYAVlstOUbwsfSFuz4pN1XDTG4
   oL30fPkyH+hnbW8V1SEiDOu3JtcJz2N7URXCI+77XN75mNn/Gxqq4+awi
   NIVMkHdzsbwTDj0Uf9rCxRok8sz5WvjWeZTrFerWzOJBqWO4EufiSZ0Ek
   W0Tmhy/zrUvgj+ClUrkO/FQLtppXTnUX6rtI96PKf2NhnyA5JyfbcJsYH
   tV9r/xajoavXKR4AnJ73JeSGZm1X0bc/5dBBjTEdlKqS8/BtuWzIJpmH7
   mUPd9gCdnAxSxS8kRxwiWU5XQiurESDy//mlbdDLVl+HAw4GubDJJwXIz
   w==;
X-CSE-ConnectionGUID: xFBbaJDIQ+usG30Y1BJJ8g==
X-CSE-MsgGUID: RcZq8vFFRO6iwFWuaVk1oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90729046"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90729046"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:23:39 -0700
X-CSE-ConnectionGUID: hROUSMktQSiu7M7VaSE+0A==
X-CSE-MsgGUID: eSOna0UeRCqJhAwhBhROrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="302464757"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:23:35 -0700
Date: Fri, 2 Oct 2026 12:23:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: adc: aspeed: Fix SCU lookup for multi-SCU
 AST2700
Message-ID: <ar94FZ2kEJZzJJb3@ashevche-desk.local>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 05:50:35PM +0800, Billy Tsai wrote:
> The ADC's reference-voltage trimming data lives in a SCU register. The
> driver has always located that SCU with a global, name-based
> device-tree search, which works as long as a platform only has a
> single node named "syscon". AST2700 splits its SCU into two
> instances, syscon0 and syscon1, that share that same node name and
> differ only by label and unit address, so the lookup always resolves
> to syscon0 even when the ADC's trimming data lives in syscon1.
> 
> This series adds an explicit "aspeed,trim-syscon" phandle property so multi-SCU
> platforms can point the ADC at the right SCU, keeps the existing
> global lookup as a fallback for single-SCU platforms and already
> deployed device trees, and wires the new property up on AST2700.
> 
> Patch summary:
> 1. dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
> 2. iio: adc: aspeed: Use syscon phandle for trimming data when available
> 3. arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes
> 
> Assisted-by: Claude:claude-sonnet-5

Assisted-by: LLM
(as documented)

-- 
With Best Regards,
Andy Shevchenko



