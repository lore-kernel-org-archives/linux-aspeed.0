Return-Path: <linux-aspeed+bounces-1777-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C72FC83F1A
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Jul 2025 15:38:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmhHV094Zz3bgw;
	Wed, 23 Jul 2025 01:38:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753198693;
	cv=none; b=QOWd0aTLQBkfRDGb36he30GArAp+HCxUXsRMvFaySf1xYXqLjtMbLb+3WpVL6kuguX+yDWkVOFmiFWXq4phD2q6RV91cWdmx3pNKz1xKwxXEm4mT08gINu9M+7JY4T6nRYNxA9nNJau2lcb72xgKhLBFj92eR64ybuq/Nipcrl0lD4fSYOh95FbwpSf2l/Uc+w/aylojXCfo0rBtTCC715bUJXzIYOVaKgshXinZtXVO2UUjSLxMFG37J79f41nWmChvxk2b8kL6aVZb4tGk188lM8I7l4fHxl1aOxvfXRwdBuAaJ+PxPS8SB70qiJfseJfE4SWVvZ2gX0pvu4lClA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753198693; c=relaxed/relaxed;
	bh=85XrHWG9Jv3VTDn16FMltpEf586hn4QJABtiSR/Wwvs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b2PnRAtWdw+jjSpsEwgog6yACf/ptwUDJctZWro9R6M9U98vOij518yDA1EgiFOKN4bJFQOtyeVmFTtS6oIUJsK1EA0zQRAgIH734WWziYp/nvMqGAI308JaGSvMYu9ToPm1qvF4eTTN+OtCtZHNzs+awa3Dh9hVhljSpIPMhv0Vf/ndh1OUjc814Bkh7ci+VM8yPY1awURFcWfF8p5hd8MVrWoINNMJ8hNFfQxsQrevSuTEvkLrA+VRLFysYOV33P/ZMI6NM6dTMGkwilnFTAHzqiU+43rWfvSTWlQemNivicP35CdghPdays324L8/i946Tmr9oUFLT2Kfu0l9hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PVcXdh0a; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2aMI2TLL; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PVcXdh0a;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2aMI2TLL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 637 seconds by postgrey-1.37 at boromir; Wed, 23 Jul 2025 01:38:13 AEST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmhHT0fnVz2yhb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 01:38:13 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753198104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85XrHWG9Jv3VTDn16FMltpEf586hn4QJABtiSR/Wwvs=;
	b=PVcXdh0a6fdgzThlV2t988DT7q7CAo1ZE4pfVnd2r9kJnW0ZZzKeSQR/7lZYqzfG9szsKY
	e5ri3xfR+DlYoP9g3JymbTygs+bX/evN+HtDtQaaFUyOUvtUlT2sggNJE7l17DW2+QLt8h
	FKCnMJKvY5nQeUVwhvrBhP+jpERaMqtvJZM3kY4fn07vLLVBVSfkKVzlbeflEVDutThOiZ
	Iv6/lU7GlnbZW9xi1iRbeowXeEpdGscP28u8aiB3VaP4v/carXHeZMTBMls64E4/Ba/yc5
	OOPRDAgpqPKgz/f6+2o40R9HUN2hD6N5A3Ty9OiSWR/nJO+xPTJKMRZLLc2fYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753198104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85XrHWG9Jv3VTDn16FMltpEf586hn4QJABtiSR/Wwvs=;
	b=2aMI2TLLvKRpRzdAWE6LR5GQ+UaMV1YrI5ZndoTpBlbt7m2b4vzw6/NttvrmH/VtNLuDzL
	j2RFiW2PS4UfWyAg==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kevin Chen <kevin_chen@aspeedtech.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
In-Reply-To: <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
Date: Tue, 22 Jul 2025 17:28:23 +0200
Message-ID: <87zfcws0rs.ffs@tglx>
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
Content-Type: text/plain

On Tue, Jul 22 2025 at 17:51, Ryan Chen wrote:
> -        interrupt-controller@12101b00 {
> -            compatible = "aspeed,ast2700-intc-ic";
> -            reg = <0 0x12101b00 0 0x10>;
> -            #interrupt-cells = <2>;
> -            interrupt-controller;
> -            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> +        intc1_0: interrupt-controller@100 {
> +          compatible = "aspeed,ast2700-intc-ic";
> +          reg = <0x0 0x100 0x0 0x10>;

I doubt that the controller base address is at 0x100 ...

