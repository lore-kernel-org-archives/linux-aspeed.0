Return-Path: <linux-aspeed+bounces-4656-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6179C2A09B
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 13:54:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGly61hnTz3c56;
	Fri, 07 Aug 2026 23:54:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786110878;
	cv=none; b=X2W53wb0qf1N4gmmCgGQQdug9dpziAh9YgU5QGmOYq0bvcNoCaucYEzWDvDVvGTqo1kKsHnmSy/XlwYEzZZkM5o5GRNoqrYK/CeoTKP53vl/h+of7qtVvgEMGbqkE79I6smSUrAJN8/zOzoIQxrB7+Yj/px/Zdl7bewWqAnPC6kJeV+4rq/xd1GzGo7SVpxcr5762xTy8f4yQqClq2gBYepz21LPvONqNzzeFVYWit4KIIzPY7Mhf2ndMbaVi4UiOqS3+BudFl67CdVU20guClvM6UH1KJLfoCilD9j9TnRYJAPyMifkbR45VyKugjtgbF9YortzShLNM/W3269t7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786110878; c=relaxed/relaxed;
	bh=LrMbeDtSQlhSgNrbLkiq15nIVBWXNtcN0NqY2+7szXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTOl1lpuisLGmBYnPgaLqfDhh88FAw+g9QAUd9gf6Da9ZrxVwHogMgNFQ9K1lmoM8yRAv7kdkee1soflM0h2GIgvMK38Mkd3DpnlN8S+inKabZgUtY2Oml6nqJHPIdlT6MpBI7ZaFnRNRyQCcHKclbPMwWIvDwu/0xLbs2pSJxM2kMf9c+UcmgPj82Wgr1GqsP9jyjOwaMAMq0MyKRBHTlmmCKenqfwi5+RpLQIEN5oHMyOyfcAi5QcM1E5XSMvDw7GdG1MzMOY+pyyQDlBpZBug0cIc71RuSOLVP20WYd4m+s4Hr26gno5zb1RZJZnxwJYtwOuBJNtc4lg1IexFUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPAz7OMs; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPAz7OMs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGly42Kstz3c4l
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 23:54:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30355411FA;
	Fri,  7 Aug 2026 13:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E31F000E9;
	Fri,  7 Aug 2026 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110858;
	bh=LrMbeDtSQlhSgNrbLkiq15nIVBWXNtcN0NqY2+7szXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VPAz7OMsggRQ7QcTvFsfkCdc1vsvSkSdCCPF+larKoF9MfnPwchfBnAhnqvMxp5rT
	 OiTJ7+CBqRK18/yFf3zpt87QSiibbNWN70Ri+NLzGCGIJpcsS1BJjzJgWlxvUELXvV
	 KLCg/kr2HK3chT/+vWvG1SGr/zk2FDWItiX4t1FGa5NBRMv1odKTInB411jK4da2wp
	 aB8e6jXbNSUC7sY3/BVt//VlwyINyEHh2AJSsWVDbS3taDe7aihnzQN3LaknnVnbET
	 VguGsEbX9osV/tzXlvUO9jslcz8ooZ1SIgsGLN2e3qJIVmHMRYSs9TVq1yw0Dk+Cm3
	 UGwvg5S3H+4mg==
Date: Fri, 7 Aug 2026 08:54:17 -0500
From: Rob Herring <robh@kernel.org>
To: Colin Huang <u8813345@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	colin.huang2@amd.com
Subject: Re: [PATCH v4 01/12] dt-bindings: arm: aspeed: Add Anacapa EVT1 EVT2
 DVT board
Message-ID: <20260807135417.GA63178-robh@kernel.org>
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
 <20260805-anacapa-devlop-phase-devicetree-v4-1-5d67e0efa6c5@gmail.com>
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
In-Reply-To: <20260805-anacapa-devlop-phase-devicetree-v4-1-5d67e0efa6c5@gmail.com>

On Wed, Aug 05, 2026 at 09:02:29PM +0800, Colin Huang wrote:
> Document Anacapa BMC EVT1, EVT2, and DVT compatibles.
> 
> Signed-off-by: Colin Huang <u8813345@gmail.com>

Missing Conor's ack.

> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index dd7996960de3..1c2656d99807 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -84,6 +84,9 @@ properties:
>                - asus,ast2600-kommando-ipmi-card
>                - asus,x4tf-bmc
>                - facebook,anacapa-bmc
> +              - facebook,anacapa-bmc-evt1
> +              - facebook,anacapa-bmc-evt2
> +              - facebook,anacapa-bmc-dvt

alphabetical order

>                - facebook,bletchley-bmc
>                - facebook,catalina-bmc
>                - facebook,clemente-bmc
> 
> -- 
> 2.34.1
> 

