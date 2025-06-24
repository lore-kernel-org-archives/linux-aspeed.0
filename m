Return-Path: <linux-aspeed+bounces-1555-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D58EC77B7F
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Jun 2025 23:25:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRgzW5Ncwz2xKh;
	Wed, 25 Jun 2025 09:25:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750807527;
	cv=none; b=eFC6LlxaZLOOHlLQxZHooIDH5BOS6m4YmyI6/GrgvV3IehFHCA9hZ8sT+sgp3zzbFr3vo85iKY3cgtqhztl3vGbh3yj568LFLDJiz7VAaDw30LTfqxG+5NlnCWx5KtoEJpglWB1g+4XAg4oj4Vk3ih0Jf7hYOv4CCKpjMNpwdUXL6vdSRSLxdH+uX8ddehqZ5m6BGblvqznZhVDo3+oothxtbnok5CndyYm4cJPanxUZ1TUSBkNKjUs7jogxTXlVax0c4pC6i7Lhwjq57nWzUQh2fvlVEZ3LP0r4+haWfo+YL8LaYO3Ry3c8WRt3HdOfME2wkkdkUD45GI6zUmtZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750807527; c=relaxed/relaxed;
	bh=w+f5W0eoB477n5tZdxO4dFP4iyclYTFOfRC2PI/WiYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B//7Jkzt2/+qIfqGXy44rSK9TNqZ6dpFj6D7xYSnDSZGXb8ZtS5/ru+Me2k6LQv+sZ7Uvn1Y9L7vm2UZxnKnnYjV0F6qlOinnnFXi21x4seWIQEsVmedJg+S3y5OmRvZ14BjbbWbhvF+X84UnZdEbmVb9r2Oi62F/gJhvgkQyVKFsN9djoJaTN3UckbYY0N9JPiveKb1r73F2HziwZTmHT0DSxF2ij1abPIkGK2QHYBz4vt0l4di+LU4gzlUGrJ2wGdQc3dhXJA/x6EEligu0MgtGFpzbhawx5uN3RaxTrbLMk2P/7q9AvhhxHCWIo0QMnBqf3ZhA6vTGwJPLI70Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=SMCN3RjJ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=SMCN3RjJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRgzV6T6cz2xHv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 09:25:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750807524;
	bh=w+f5W0eoB477n5tZdxO4dFP4iyclYTFOfRC2PI/WiYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SMCN3RjJLGMVXWlCMZWDR6UnRhkHcHT/gEstpcg32yeThnUmB6Gv1XAflf5HeaSRg
	 T3LMr/jtSoAOdYqskjI3FY/MeMJ9+iVYDyin7TYwVsiwS3WrM/M3/Tb1Lc068tVrPN
	 CYrDZOKXWvwqJNAqrVcoCCTPii+Qqdfqwx+uF3PyhMgDrSpdn6Nkh/yhZwQYM2tsf0
	 jga6hPoQ4mJxtCeTP+ReDsJE2Tu2jol6+7d94Yqj2fX7S9yQpFhY5PZN4mB356fM2V
	 uEMSlt6SbF6ZPDwAQYmzS5qK+skcHVO4uXF23f2m84Sf96sq4pU5ttMrWikiK0hBJO
	 qH2eJULGxULRg==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 329D9640CD;
	Wed, 25 Jun 2025 07:25:23 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, Cosmo Chou <chou.cosmo@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 cosmo.chou@quantatw.com
In-Reply-To: <20250622034247.3985727-1-chou.cosmo@gmail.com>
References: <20250622034247.3985727-1-chou.cosmo@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: bletchley: enable USB PD negotiation
Message-Id: <175080752310.266748.15058369884173202115.b4-ty@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 08:55:23 +0930
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

On Sun, 22 Jun 2025 11:42:47 +0800, Cosmo Chou wrote:
> - Enable USB Power Delivery with revision 2.0 for all sleds
> - Configure dual power/data roles with sink preference
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


