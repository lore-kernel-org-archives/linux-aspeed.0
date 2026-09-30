Return-Path: <linux-aspeed+bounces-5084-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A7ECA5FB1
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 10:38:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvs3M46Rbz2yjN;
	Wed, 30 Sep 2026 20:38:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790764735;
	cv=none; b=cbZtcWKW8cJebjYNWqn6a+Vbmr8SzgbZuIlWJxafXAdbtOzb7uBvDWX7evr9ySAySWSX2b46O8yYalfWG85yx9eNknaDdQQ1c+q0FfJkny3EHFLVTrGaMULPcj59CiPHabxb2mvOVGJOzv0afZVZCuXdHc4B0Y2japAccoLkGTRrBWExMnkZo5nm2Yxny/ieSB8fZDlXv9IjsQU2lW/ORsun/vPeLcymCMSCLildoXflNvoirgCvLBDDpQtRxzuP/464gCy55+9n5QHyoCQENgYbdl6j8edRcCEJGgBQn8r01vTuN1d+JIxIYVZI1We3QptOwwO4yKjuu3naI0Fi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790764735; c=relaxed/relaxed;
	bh=Q42sMmac7vKYGCVFrMdhSVkWOijsRMSMvzwOYZNiU4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpXZf0EKr/9/KE/CZT8/QjCLSIXlm+xBgvxnMnUGQ6tXYPbAsw3pvrHv8zKCLo19IMb6LztwkZTOruPjXQVgqzcZ8NCGTbqyUvfH1b9qOs7qNhKfw06A/lWP9SoOR1DyFdG9KOTRnrOF+J0xOdvrN+OYJtGjJAYpX34VTjth4QM2hPznNE2Jcl9lG2SDXxSlGF97S2USBXWCsLl95U3mExnbvxjEDYp4NKkMdr8uxSuHuXx8o8JuRZvfTWvl+BvhpwVsjqp1mJ+4gcE4f+iqM2Y5U8JI4TWCfmXmpwpACcvQzOWs/0snnw038yAwOlHcdGThNppHrsNtRg7Xnk+5Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iyj8/IOt; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iyj8/IOt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvs3L13fLz2y24
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 20:38:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0DA2B40E19;
	Wed, 30 Sep 2026 10:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1551F000FF;
	Wed, 30 Sep 2026 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764730;
	bh=Q42sMmac7vKYGCVFrMdhSVkWOijsRMSMvzwOYZNiU4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iyj8/IOthcCiozVPuAmYxSU+qxe9W3l7Rnu2ibWzZySm0kt6WYVvXmGGRZJn/mxSk
	 2Uj3+6OOvaA/FpyxtiBudhFjCbFkOuL5/2/7nVCaBFei/pJ553tE6EQ7tNX+xnr05f
	 uwrzIkdTn4tvZHbrmM4k6bS1nJuvfNygSm7j5IMNdRYH2j8UMwj+Z6eOdaFTbJCgiy
	 7fYP6qGK9og+2MXyk8PSjx2rvyergNkpOZ86+dPZ8FuCRfI+eXw9ns4JOw4a+fcrKN
	 LyUtKtJR6ZFs/bOHMR9DuWiK77xEQKrLNahF87S4noE0xE7jFTJyHdlOjhVJs5H73O
	 x1INh5aIyGlxg==
Date: Wed, 30 Sep 2026 12:38:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sue Wang <suwangquanta@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, patrick@stwcx.xyz, 
	Steward.Shih@quantatw.com, Martin.Peng@quantatw.com, Fred.Zhang@quantatw.com, 
	p.k.lee@quantatw.com
Subject: Re: [PATCH v14 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Message-ID: <20260930-curious-narwhal-of-calibration-62442d@quoll>
References: <20260929075106.74731-1-suwangquanta@gmail.com>
 <20260929075106.74731-2-suwangquanta@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929075106.74731-2-suwangquanta@gmail.com>

On Tue, Sep 29, 2026 at 03:51:05PM +0800, Sue Wang wrote:
> Document the new compatibles used on Meta Ventura.
> 
> Signed-off-by: Sue Wang <suwangquanta@gmail.com>

Please respect our time. Actually other contributors time as well.

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state in the patch changelog
or cover letter why and what changed.
</form letter>

Best regards,
Krzysztof


