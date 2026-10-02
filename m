Return-Path: <linux-aspeed+bounces-5109-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE955CA5FE0
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 08:34:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx2C26qr7z2yPG;
	Fri, 02 Oct 2026 18:34:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790930078;
	cv=none; b=W1GEeLIaU1ABKz6afeIc/9JO0t6PjF2CE6KgXARZ43DhFJQP0Tm1uMn6JIcDaHPWHZiJGdZC62wwhO8pVwsnbKNWnyIkwBW2LC1BJLSeWVvtIn4N3W0Ft7Y7hrg0hQCpBpV6Y8kyTc0X1Adm9+uLLeAF7FzYKWg/tNB/yGJve5qCaxI6fQpZBOMLfJoaFGDXBc+CN+h+SuKeASn5cXouCwXSx5PyC15E91fqiwJEJGtoOS0+zPn6xa3hH/kqE0B/5Z67hHTOx2KvxIRDb4PelgasA4O3VxphEOoxve0XUdoHi+k9b/LxAgeI+AVPGbaU6ckK7NMKmSMtajkVo4Lscw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790930078; c=relaxed/relaxed;
	bh=e3odjPKg0raewtAWyX2qeq1zPtEEMLRG1OzYoFe5p0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTI6bGBlak44fZAKeLnKn4FQaqUhmDxpm9w0jWQW5RldPzU2uboJwO/BfDmlFfGhVJJszlc9lRh3ysBWJB+VtQTx8X6BvOe1kUGrsOiKHB6sKFot9yRR6UZAuAd4vjVlaSZy7Bqu+ttp7G9AP4sS5479DtYnlk9ChyRVDAe5meJp/FawX3JineSVu2XeMpIi5+lk2xAYlbpj+8xStOLWIU/mpeU0AupFb+p/P/+NuQgFoDM4mZMZW9+FcCX0Rs8JJyrpge1Hl4GQp2ucb4S5j2O1HKM4EF/RzSNDi4eJCcO8JwcleqMXzBTK5k747d0CtaDFc3o5q2ufqZ+f0Cwr5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QkYV43hw; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QkYV43hw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx2C03zWgz2xsW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 18:34:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790930077; x=1822466077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9KlofZvJbEKRfC9/pPIiIB0BQQWbJgdRDIvxhFmb7jg=;
  b=QkYV43hwKZ3XJct8NuBMhsq4luWdByydWquey/44zjVkeUVcx/EePzg5
   up96bt+WDjQr49oqcyv+ypXidPPqbosV2nqdNTvdAbfrtY3FV5f49aYDU
   907MdFWNJ89TAbKmZoCYDC+Oicrgu5p9fTS5O/GsS0omz4s6ytn7Nf++q
   vBAynnCcHcWIGTEUxAX5mQX0sQ6rehOCCItRVuwKbvXN9t1PZCkFOCUZu
   qL9cViePIeBhyE7m7bYeDbRKH4kYWfOO9v67pVhmvCWq+ValO838JcYpo
   bdvEFunCUhH/kiJSh6EKjrwCh9vwpTzJOvt6ysLM8D6aqwq0ccKOo1737
   A==;
X-CSE-ConnectionGUID: QmTn/LfJQ+Wy901srnmEjg==
X-CSE-MsgGUID: V9cguTQZQtG5vFhR99YHgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102369783"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102369783"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:34:31 -0700
X-CSE-ConnectionGUID: D+ozLVgTQLWiIdHdGnSY6Q==
X-CSE-MsgGUID: oWQTTd30TXKky1l7gTyKtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="304166086"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 01:34:27 -0700
Date: Fri, 2 Oct 2026 11:34:25 +0300
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
Subject: Re: [PATCH v2 2/3] iio: adc: aspeed: Use syscon phandle for trimming
 data when available
Message-ID: <ar9skaV0Vii8oX6G@ashevche-desk.local>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
 <20261001-ast27xx-adc-upstream-v2-2-2f9c15cc0064@aspeedtech.com>
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
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-2-2f9c15cc0064@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 05:50:37PM +0800, Billy Tsai wrote:
> aspeed_adc_set_trim_data() locates the SCU holding the ADC's
> reference-voltage trimming data with of_find_node_by_name(NULL,
> "syscon"), a global search that matches the first device-tree node
> named "syscon" regardless of which SCU instance it actually is.
> 
> On AST2700, which splits its SCU into "syscon0" (soc0) and "syscon1"
> (soc1), both nodes share the same node name "syscon" and only differ
> by label and unit address, so the lookup always resolves to syscon0
> even though the ADC's trimming data lives in syscon1.
> 
> Use the new "aspeed,trim-syscon" phandle property when present to look
> up the correct regmap directly, falling back to the old global by-name
> search when the property is absent so existing device trees keep
> working.

...

> -	syscon = of_find_node_by_name(NULL, "syscon");
> -	if (syscon == NULL) {
> -		dev_warn(data->dev, "Couldn't find syscon node\n");
> -		return -EOPNOTSUPP;
> +	scu = syscon_regmap_lookup_by_phandle_optional(data->dev->of_node, "aspeed,trim-syscon");

Do not dereference of_node, use dev_of_node(), it will help in the future
if we want to reorganise firmware nodes in the struct device.

> +	if (!scu) {
> +		/*
> +		 * No "aspeed,trim-syscon" phandle: either a single-SCU SoC, or a DTB
> +		 * predating the property. Fall back to the old global
> +		 * by-name lookup for backward compatibility.
> +		 */

So, why not doing

	struct device_node *np;
	const char *propname;
	...
	np = dev_of_node(data->dev);
	propname = "aspeed,trim-syscon";
	if (of_property_present(np, propname)) {
		scu = syscon_regmap_lookup_by_phandle(np, propname);
		...
	}
	...

?

> +		syscon = of_find_node_by_name(NULL, "syscon");
> +		if (syscon == NULL) {
> +			dev_warn(data->dev, "Couldn't find syscon node\n");
> +			return -EOPNOTSUPP;
> +		}
> +		scu = syscon_node_to_regmap(syscon);
> +		of_node_put(syscon);
>  	}
> -	scu = syscon_node_to_regmap(syscon);
> -	of_node_put(syscon);
>  	if (IS_ERR(scu)) {
>  		dev_warn(data->dev, "Failed to get syscon regmap\n");
>  		return -EOPNOTSUPP;

-- 
With Best Regards,
Andy Shevchenko



