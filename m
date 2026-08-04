Return-Path: <linux-aspeed+bounces-4605-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F0CC55838
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Aug 2026 12:20:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDt0g641Bz2yLY;
	Tue, 04 Aug 2026 22:20:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785846019;
	cv=none; b=Ww7eg7oVFDydz3gIfBYhCVmNcmCMYPQ+Rk3GnB283P6CkmEeVZjzXGp/9gzRRWAu8MFcdXB0+sXN57J0ydt+fY4Z1TPDcxIAI1yDJcwE2XfAgKznyXsEtxsvmYhQHrlh8iLOCFsMgt2VaUwahfqoxYHc7ATxxkt8jyV7T+QBN+pE7e8cxM1jU5caij1MXcHwevgjZHDi6nMwBWc/eVTO2L8XXfjVHYH0vU/zZDL5pg0BYWXkLMdIuRXtKiChRYiiT6DgmlMHPOHYKSU4Buu+qVjqXNTfUtlKvCiiNSOy/AuQVPR8TPefAsq5/gnIfWNH3MNCwaoeKErv9g1FlqSsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785846019; c=relaxed/relaxed;
	bh=43V8Vcr7/ZgENMRf8BBVhplkuKW0VEmbjigo3HtCvdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+G77olZpSaGYVZQOGPDaQjIim1xa66+slSTOl0jHvcH4bda2GKIZiTyDUcZTKFj8xkfvFf3cip6oVPyZWp41WvOQ+8u8hCfD2DmpfxoDhuMBX8WmAvloEUR+m1X8GVc2ZZjiXMyLndaG0EVCf12R+FSDPlO92rTB5BrPAo12FQtO1MJ3LgCDmtZGVieIBNo4rdhlcKHxi7hCOENhgQVm0Vm137PED85L3qMfKMuBOSBVw8IIshDPZ2oeTCMLcwJo0z2aDxoM5+gw32jjIsWVC8hi50jhKgn7x/1LhzfsoVXvRH+QiSvClu2DDLiGHX7K80osB/TsuVMTNFjxE3whA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1AbMORev; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1AbMORev;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDt0f4LN0z2xyk;
	Tue, 04 Aug 2026 22:20:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DC00E60A59;
	Tue,  4 Aug 2026 12:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E536B1F000E9;
	Tue,  4 Aug 2026 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785846014;
	bh=43V8Vcr7/ZgENMRf8BBVhplkuKW0VEmbjigo3HtCvdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1AbMORevw/0tXDtxT40hlAZbaCbCxKN9m9NyY5H4VnoRPpgjFifbYKzabDZ87WFF7
	 kX8Ba+wST/MIfOOrHdqZhK0wJszsesHQYg9j+sQgww2/PajD5XidguA1Z8Veu4cmEP
	 rdUtTqgANSlDV3iEun4ki0evO73huS2jjaDCvaV4=
Date: Tue, 4 Aug 2026 14:18:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
	linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
	bleung@chromium.org, groeck@chromium.org,
	chrome-platform@lists.linux.dev, corbet@lwn.net,
	linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
	andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
Message-ID: <2026080416-lagoon-delirium-8e84@gregkh>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
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
In-Reply-To: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>

On Tue, Aug 04, 2026 at 05:22:55PM +0530, Krishnamoorthi M wrote:
> Feedback Requested
> ==================
> 
>   1. We chose a dedicated bus_type for the reasons described above
>      (capability negotiation, four independent channels, asynchronous
>      ALERT#). Does the community agree this is the right direction, or
>      is there a strong preference to extend the SPI subsystem instead?

That's up to the SPI maintainers and developers...

>   2. Is the blocking notifier chain the right mechanism for event
>      delivery to slave drivers?

Notifier chains are almost never the correct solution, especially for
real data you wish to send to devices/drivers.  Just use a real
callback function you have to register for, and a workqueue, or
something like that.  Ideally just use the process context of the thread
that created the data in the first place, why can't something simple
work like that?

>   3. Any concerns with the ops table design or the -EOPNOTSUPP fallback?
>   4. Naming and structure of the public API in include/linux/espi/espi.h.

What specifically are you asking for for this?  Do you have userspace
code you want to integrate, if so, does it work with this?  And where
does it live?

thanks,

greg k-h

