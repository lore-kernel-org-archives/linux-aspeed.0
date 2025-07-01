Return-Path: <linux-aspeed+bounces-1601-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6EAC8302F
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Jul 2025 00:16:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bWNr74jFgz2yVV;
	Tue,  1 Jul 2025 10:16:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751329015;
	cv=none; b=f/RA+GGArkjsTSDR/WrOYHEsNvs3KgKMQaj/7PPJ8IGP4baQbTa8G3tBvLBQE3UcULfn9dAbzv+J9/j0aO0oMMQ3if8I43cxQgKmusMErUqgbQILBk8xbB1mu165gFwJX5EyAH6kqay5onXboRVIIfwSGdLyQzJG4DKCCny1XAqawnMcr6B1MmFsR5SUEIys7XnAt7T+E8Q2HkDPdbxt/17eNmwvqjIERCo5mZjlfxwMtzRdXMvEIagRzn6sCMWHfBeNZCcEHHxPNX6N1ST62ESJve7516ATMDCYTvUb5zMzZvgmqEaNbgmqwEBg9my1ONpklsBm6ddKZ3rgbUeG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751329015; c=relaxed/relaxed;
	bh=hvoathe2minC31qj03ooB60wR+d2j58arkQnnk4R8YA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D9jrQO7US5F8MQppb2Q0OCyZMLj7kwCSzQGwbeJNkKgyl2cSe13wz78LLDzxZtnqRW8v5FpLPCqVENM8mDhRaPz7sUFbT75SfAPzwV0jjAv7pqpa2ER51b4thaVA/mpgZA8iVRuN0AOimomUGcOhpcl2UwqzUV2ujlQmMlQnqtJwJ6rSzAnxkAVTP3S+QTXGLN1V9qgAC4Lqv3RhJKh/54TZ52zaGZnY0qmRRJMfr9a5RkZM2VcwuMQ+kDAg20+K9NwG6OGa0gBiojx6RkBtSNuCtYZuRN//mE3DHn16nNPZdSvDOzHdd5hP5AQqa67eiO2OemmKlM6F4STVOdukRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RZWtX3aQ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RZWtX3aQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bWNr61Rqnz2ySY
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Jul 2025 10:16:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751329012;
	bh=hvoathe2minC31qj03ooB60wR+d2j58arkQnnk4R8YA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RZWtX3aQ1OJJSOcPc0ETc2Ze7JRQhY1qj+uePmSqazjcFGU5y8b22+UowAKECjvXl
	 rpnm9le3jfroboA1St2+StF5q39pnMd+gjURPYFVRHzvjyY5YW24J9t+E98C6inJUO
	 SsV64c6V2TzTfR+wVCiXnpITnjcM+q0SpkOPbCnR0N+N77skmsVTb5XVoXnXWK1CS9
	 p/oA2+S1pn910DbpDa37e+5KgLnv3AOGq4LrBQAnwO0e94IVZ9LU1mbPH95qF1VPqW
	 ZSycR8mSa82XoEOGAsOCY3j2ElclyPZExZQUgtHDvLGhGS+Cn0XP/yYU097Vd25Cuw
	 dRYhBE2BfTEqw==
Received: from [127.0.1.1] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2C47E640B3;
	Tue,  1 Jul 2025 08:16:50 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Marshall Zhan <marshall_zhan@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250630073138.3315947-1-marshall_zhan@wiwynn.com>
References: <20250630073138.3315947-1-marshall_zhan@wiwynn.com>
Subject: Re: [PATCH v5] ARM: dts: aspeed: yosemite4: add gpio name for uart
 mux sel
Message-Id: <175132901095.54792.12200042730026640443.b4-ty@codeconstruct.com.au>
Date: Tue, 01 Jul 2025 09:46:50 +0930
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

On Mon, 30 Jun 2025 15:31:37 +0800, Marshall Zhan wrote:
> Add gpio line name to support multiplexed console
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


