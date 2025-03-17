Return-Path: <linux-aspeed+bounces-1005-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD829C282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 09:12:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGTkm2cr4z2ygD;
	Mon, 17 Mar 2025 20:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742202736;
	cv=none; b=JugSyurWV9Ib6nBGayOzOjslVCNbLyrn4xrRBEz3JckWOPVOHyjpEYSCa6WyzLbB6jX0SlK2ry+msou28Gg/WlRJv0LgPAjuLvDKzbufJlojUFNOHkAp59PMn4Hb0hvwm1mvyDd41jOtvxmSbUWKYwSqfsaZV3y3pK0WX7tnXhIaIGY9hLbaOsdR59wDWX6IXm78O3CCf+90yd1ftv0pN/6QC2E9VsPqirwW0vQnzxSERZh05MIWeZBT2V0HH3JA6bM3Y8jdBzgCdaCA9lMp/aiUWjAdi4zch+DcLhVlYM8+CavCC6IbqoBiP+P7JaewEW/pinZcVPqaF2PE4DuxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742202736; c=relaxed/relaxed;
	bh=olOSeqyFvLZJ22LOKLQzX5hVl6+fQaIqyTnNhGTHkEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpVHncCBBTi2QbJgj7v4qx6aEi6KohAwB0vrtu1biPRQM/Z2iDd1CuMDnIyVwjj/kzbWwVSsYHmTYYkGiJyp6/EGDsyxhYUxR/yuf1xTVUzXb9yoT/EFN2obStn17IHmoWJziqs+Y50c1d8ICsfEf5TGUwkQidC428KLMySIhEDIJwjNyBnrnIphedWhHfmDc4q2Xg8jdJu206zE3NX7UmomGfIynS2Q+AOEF8Q/igVg5mGxC6wfTi44O5Y3W95x0FF9Gyt/ZfqUlPAybxaPC0eklIDGjyauVY9zHocv8We8eN30pxhh7DFM4632YCWJQNzklIu6UyV5xwXEZ1FSQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N9zA+Xp0; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N9zA+Xp0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGTkl56CZz2yLB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 20:12:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C2B1F5C53EE;
	Mon, 17 Mar 2025 09:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A342CC4CEE3;
	Mon, 17 Mar 2025 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742202733;
	bh=qIi66nAJAkuAxof/+NyK+41N8iuL4BfxKI4FIhK+u1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9zA+Xp0IhuHdLpAzNn5wQcFEUuALfNeeC+ADEXYSrdG2dr0CzGltKDfSNv7TGriK
	 xa+DMhe6aYwswcdDVsrTGyLmLVN1roHXa6MHTRukYWM1wm3xFh8h2nOEpRrMAubbgF
	 cj/GffCiF+LqdNvZRKfnHuacqjaEnIEPDcFtPERSf3TfF5kOq+1EcNR4juOWOspkuV
	 yOQTBCl/wwE6q/KPCSEDR7cw/FfuKLU9xdrNrf/jf5TvEpFVu8VNYt5u9wyH9FLFp7
	 qOzrZco6DMF9VCUnLV8zusU7wMpqzvgAIIZGJrQSACOiD5LZKUBS7qak6USSxPDrr8
	 z53XPztZlUb5w==
Date: Mon, 17 Mar 2025 10:12:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-binding: aspeed: Add LPC PCC controller
Message-ID: <20250317-hypnotic-boobook-of-discussion-fdfe94@krzk-bin>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
 <20250314112113.953238-2-kevin_chen@aspeedtech.com>
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
In-Reply-To: <20250314112113.953238-2-kevin_chen@aspeedtech.com>

On Fri, Mar 14, 2025 at 07:21:11PM +0800, Kevin Chen wrote:
> Add dt-bindings for Aspeed for Aspeed LPC POST code capture controller.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

Nothing improved. You already got comment that nothing improved and
you... send the same.

NAK

Instead of selectively ignoring comments, go back to review and
implement each of them.

Best regards,
Krzysztof


