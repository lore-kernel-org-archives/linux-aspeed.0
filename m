Return-Path: <linux-aspeed+bounces-700-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5628C02198
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Feb 2025 06:44:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yt81c3vTLz2yZ6;
	Wed, 12 Feb 2025 17:44:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739342676;
	cv=none; b=kRKOvo+QVsEChqnuVWJgIftKIv4qXATn8I8FjQHBpZurpnAk/HqBBMjkyEwfq0FQXjeuOgrs8jLyqRpIKqW9ACpHVWHuMdFolkUR1h5lI0oqG1LOpg3gHewLY53IpbRX5hjcukUAv8Y3nKHPeUngPVTOp8PvhaJcATqBqW84MWibbEw0SuL+tq5Sm4tqsCwEbOYUWYGCw67DEzB0qMBiQbxB1lCZkwzMTpfL9xjV+UDmpi3u5BBCHYtEHuCN7EimdODkemWgG56q4r3RmMgnr2oc6qKZ+RlQYggjg6EJHDdN8Vs5qc1vxja7CwU6IdTts3PLIduRHBlqRb8xmztcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739342676; c=relaxed/relaxed;
	bh=qCJf3RdMRIDtsyVFtsT7i6n1XVBxH7JnaQG1mSyRKT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uotrz/JVLbPGFI+gmAnMiemITYCQdXUDQ7E0otgzC9Ee7Qbj2g0cCHtn2XGlolUHkkBsMXTUD+WNARnfq2aWOprwLLBDfx4EiEz/EmhyxEsYHeDzww0TXQIk6xD2D/jHoIka3lULln3MNNlXJMN8gi7wJHCt9QhOZplmNI70TxSukoFfxag3GD++zwdl0zzP0rFTt9WJD4tbp158XUHw5gmtSXm3AEieFIcG1GJPa+J17NTd1oiWpcfTtMVzB/ubwIL5DP2zPUyAx8QvkI/OrrOVQkdtqWU+b+wiz5+WTq/TH3iC6IecIZahsgWCTpcLZFCjr+Mw/2k6jdrXj201LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tfUXC0BL; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tfUXC0BL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yt81b4BHjz2yF4;
	Wed, 12 Feb 2025 17:44:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AF933A40FA2;
	Wed, 12 Feb 2025 06:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505EEC4CEDF;
	Wed, 12 Feb 2025 06:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739342672;
	bh=Sv9qNL+TN5TjV7dcAh3uCs0tMgt7UdZj63e5XWo0KJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfUXC0BLirlUXBWTvvt0AJzcvF0lHh9wK8R5XaaS+Wl1kkpJ1p251RZ3KuZMnnY4H
	 hHF8g/BHY2ZqEwg9csC76QN/ORdw2gqcmxpwnGKXUNr7EfLik3ayZfaTyNrgtOMGeZ
	 fzH8JvLwuIsqof/UnySBYsbry++vdHDaZ0rj+ifOdJovO0mB6MaYCwdT37ZzMu/me9
	 jqVmmb+GaMwFC1+WfvFoUnehxg6umOkJp3dt7Dwzhm2OYDPWrkVF5t5g43esQPvnAF
	 WaI4tfXxlwkLNy1xuEfxlIuY0638gIUBdtffuu/kBnld5maDpljDOqAn5E4L1lx3nU
	 jhNIek9FoKY+w==
Date: Wed, 12 Feb 2025 07:44:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: eajames@linux.ibm.com, mchehab@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au, 
	linux-media@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] media: dt-bindings: aspeed,video-engine: Convert to
 json schema
Message-ID: <20250212-copper-tortoise-from-hyperborea-8dddcc@krzk-bin>
References: <20250212014711.2181865-1-jammy_huang@aspeedtech.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212014711.2181865-1-jammy_huang@aspeedtech.com>

On Wed, Feb 12, 2025 at 09:47:11AM +0800, Jammy Huang wrote:
> Convert aspeed-video.txt to yaml format.
> Update aspeed-video.txt to aspeed,video-engine.yaml in MAINTAINER file.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  v5:
>   - Don't put additional changes in this commit.

But it fails then, right? I asked for justification or separate commit,
depending on what is really hapenning here.

Are you sure you tested this? I am pretty confident it will fail :/.

Best regards,
Krzysztof


