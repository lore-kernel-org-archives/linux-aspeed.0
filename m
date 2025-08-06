Return-Path: <linux-aspeed+bounces-1906-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63628C87FD1
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 01:06:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxXDd3g0Zz2xck;
	Wed,  6 Aug 2025 11:06:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754442385;
	cv=none; b=jVZak4RZHBQAApJ5cAP2hJipKFXmmvEET/I5DEwLVWyVJ5F1dXyDorJDI0mbGRTK3StEvYoWLb1/ecr6VvoRcfEvGJZZFwxvfiD40Jri8f61PScf1eCoSuPh6y/hQNp7asbOan8jPtjo2CLg3dnZj/DFiNC5H9sdj5NdDy/8FUQyLZhT8+kqQdPAvGNf/t/ge1ZFYvr8DPL0ClYJqHzIh4jngP/puVEVmGrDEG2BB8YWJWs9ZvYaS4oCrHPMjF6LUriAShXMa6JlJYRWxTOFhnF9RrlQQzasqVnaORyEei+3M0WARogbyscmP4GUjKDCpxy30QA7S5h5ECoNGeWXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754442385; c=relaxed/relaxed;
	bh=gJIT0RKIFHGb2UNWgeL4YzLrs92/FLX3uGi5Yvs8A6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V7W78etarp1LqPTRGpr/rFu9Pfhmbaxaba3QNK0Eb+lrhcx5peuciPdGNvFeuc+cB7Q+r5E0efuwQDyWRjXAyHUhTAloAnvV38/UMsZkx1IMLAVsBlnOMafuxd4l2U9NeVRP2rAbMEYu1xGeTfa04bmFfNNLf30y95z4gKIxlcH3q4sane0RgGp0uUiOIpM7wnKAx6M6LukLX4fXkIfFQ0Hk8AjAcHpxRlaeCpa7BcDYVH8bOAZGDbDCdXwNiEljpyfUSoT+X3Q0cXywIjMOM4OfxrqTXWxNWwLsuu4d8TnwauqDozWgI1CKedKyUt3I4VhcMTvMPseMEh3JHf+w+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=TZ81NPG0; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=TZ81NPG0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxXDc6dCWz2xRs
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 11:06:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754442382;
	bh=gJIT0RKIFHGb2UNWgeL4YzLrs92/FLX3uGi5Yvs8A6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TZ81NPG0Tpthj1GIOe4bGS2Jubcfz/OZCd47fs81p3MHlpHRx/JE1InaYGm1VNmOk
	 eegoZnSabX9UsZBc5kuxapDFz38wPr2kJfNLamgqMfqaKGt9KBOM3d2zV2xQJyPvbH
	 RcgE0jDa5P6hZTKSC762wBbswZAcGQr8R7iyf/uIF1qA5VFEJlMytsYQnRMuquWltS
	 MsooPpG02HSaArN3UPkzb16C464yxUmRG92PbOAQrrKI6UZ60k0uHV50kfPsphAoWj
	 uKxxH8XDDXSROrQApO09PBPyG1UTiK5scUtVKJnisHowTMYQrzGg/7kWXkIswrJZoQ
	 PFRrzAFd7f2Ig==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3982D67B49;
	Wed,  6 Aug 2025 09:06:21 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Tan Siewert <tan@siewert.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250803151822.68080-1-tan@siewert.io>
References: <20250803151822.68080-1-tan@siewert.io>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Convert remaining ASRock systems
 to NVMEM layout syntax
Message-Id: <175444238112.266976.6701389016981871511.b4-ty@codeconstruct.com.au>
Date: Wed, 06 Aug 2025 10:36:21 +0930
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 03 Aug 2025 17:18:16 +0200, Tan Siewert wrote:
> While investigating an issue with an ASRock Rack platform, I noticed
> that most of the ASPEED device trees using NVMEM cells to populate
> MAC addresses still rely on a deprecated NVMEM binding syntax.
> As a result, the MAC addresses are not populated from the
> device tree/NVMEM cells properly, and an address from "the chip" is
> being used instead.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


