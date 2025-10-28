Return-Path: <linux-aspeed+bounces-2670-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C5CCCF9E0
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Oct 2025 10:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwmTN4DR0z3bjb;
	Tue, 28 Oct 2025 21:15:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761646504;
	cv=none; b=BtMOCZlzdaEp/Kj0sLogalBQPY2eVjtJ2nLoSCxHsKKeo9W1059ya12lKPUaqjs7E1+VRvRLZgQASqOoT+ztIyO7nY5YteJ5vTVV602ZjHYEBlzEHCd+cY9iEtytL9Hys/yYk6t9CKhTkUShQ0zGUqUYgXjIgFrQWxgHiVgHlZYPksYkd5QqSUk+rGPQ+gDES50bN/Wv08/M3xtsXKW/wFd16n6o2L9IbU2AcqVR3K7+o/kkh7CbB+5tvwVD2WnCVwVt+YV/r4SimsbVkHut/0CIhRfL7OKgDdlj8m+iYZokRF9L5sZA/+9LYGOrN1Ai6JZrwUwHkRaSOpENifK5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761646504; c=relaxed/relaxed;
	bh=oDXbdM4qDrP50j7J2TcIVdmGclkOYUoKSDYJlKuQXMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLGMlU5MnBwFw6AZXDj8kjNi0JMbwXXmk92cwcVKmRTvZ92wTh7x6bpQwTJHXqvCGtm3NkGmTyyR/2tRbiHRo+jyVFbOZHz6Rgv9yhCJHtmcG1+dXDY8ZJX684fPSpiIpVcslcc4aywdG396+Lc5oVwXNCjH/J+JFgtG1ppIQ1hDIbr2FwEs5TU+UVpe+jsUAWfzJckfU2djsvNRWnHXTF/L63+lt3A3wsla7m1eq2PDqqaDv7ZN2abXHuom+1AL80bv7P4Y8cI8PGcluQSI7SiVvDNa60sOW26U/gdwx66JjiHeRUxKYCuthzS0xR2+KNLBiMf0YKT7NVkTa7ruSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GHozA4zc; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GHozA4zc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwmTL18Jmz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 21:14:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761646502; x=1793182502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4xas4y94vi3/3tBwp2J+Ktp/jrZPl//0sQ0Xoe5S36I=;
  b=GHozA4zckgbjjdwjtl3oA53pqGmkoypRFYjYdSs+ND+F7bJ1qcQk7FBD
   SQxqKrWYfz/xPb8I+B6yk1U3aoIYHfiqzBw40KDQJBnOgDx7DhZ1sOS51
   4NKhGg6/772TNTfy6XKFT9dTEXfciYBOX7QYLvAndq2/mePqU6JUJSVNx
   NEBTbN57ZAe1iXsreVrx5YVqVFTABXQNBaEWHBaY+ofK1d4iLgEztSmxR
   IKvrmsOmiDWLGlODWa3sq9Q2wUP2b0D+4yBajkg+6L+2gBWbFd4SwSeUn
   8Ar2CLf7qyUdfHS6oQI/XknScgzK8kQ/IYiAxUIc+eKCEU67LnzZz8H9J
   Q==;
X-CSE-ConnectionGUID: bN9S07ngQxK1g0w2JzTeeg==
X-CSE-MsgGUID: 7OOHaGxAQDeQhRpA/DqZpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63646026"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63646026"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:14:57 -0700
X-CSE-ConnectionGUID: iFQ8YCGpRB2ERMJDAZdzpg==
X-CSE-MsgGUID: 721JDO40R1+Z9Qpg7Dkeug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="215964946"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:14:55 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDgj5-00000003HMI-2Wgx;
	Tue, 28 Oct 2025 12:14:51 +0200
Date: Tue, 28 Oct 2025 12:14:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: aspeed: clear reference voltage bits before
 configuring vref
Message-ID: <aQCXm_rvwpB6-UUq@smile.fi.intel.com>
References: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
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
In-Reply-To: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 01:41:02PM +0800, Billy Tsai wrote:
> Ensures the reference voltage bits are cleared in the ADC engine
> control register before configuring the voltage reference. This
> avoids potential misconfigurations caused by residual bits.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---

It's a v2 and here a changelog is missing.
No need to resend, just reply with a missing piece.

-- 
With Best Regards,
Andy Shevchenko



