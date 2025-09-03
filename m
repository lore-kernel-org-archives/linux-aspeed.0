Return-Path: <linux-aspeed+bounces-2124-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0F7CA100B
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 06:07:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGsb26r4dz2yFJ;
	Wed,  3 Sep 2025 16:07:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756879646;
	cv=none; b=A8nsc5ed9dgUKSoRM4fFVSVxjNEmo7bPy58ZsWHX7cMXdt0d504zIfq7CdHC7JkjAOTubBNUtcfmVLrRMwLpIKge5sBB+7jZkvtiiA5GalwGYSXe96kFfCxXXfrJCZKJZLqDA9RLw4yG5j4iD92z/DUJwq8/GyWjRrWoWGapXSwBBK50UWE7INklsASMc8Lp/5g/D4t/vjPd50XVR9fXJLqj2M1J8PcYEI19LorH6ujPDuK6S+pTdbTVqxwirgxUPpblzPsWMwWj8uMQ+2BoP/nxiU2vDupcyY/sE70J7HWfXaIZBeeLU/gvmX6SHPHIQRiG8j3RqKEWdB6kCaSmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756879646; c=relaxed/relaxed;
	bh=4RROh9iqQ70OdBywmW1IULQcZq8kweW4OW0QocIf8EY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FIGZxmwhLBDKGOl6sF70X4uJGHszbbsSbY3MijKchXMxdgRF3SBEtJAlyRypw/o7HQ3yxsOccX0tWH30TCT4Ljzt/8K/mY7607UDfTG8vTp2y8Hdyf4sia20SgXhuXs0hPKPw+jRgiJZrjBkp8VolpvPH9wugc5l0fOkI37cNLr2pO23fUKPzNi0RpYSY+knDoygcqdEx8zdJzphz78QaNb3SbcVQePAkGbVd1n3yC1o73JdW1Oyf87PMgm++qsDHTlFn2DYQATI284p2qsZ4OFwgbHFJopUtuuugA1BizW35aeXWxmMGtBiJVEeIsI5tGvgmQ5p43jBsK4HwZJBng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GSYt7p1g; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GSYt7p1g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGsb23Xvcz2xnw
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 16:07:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756879645;
	bh=4RROh9iqQ70OdBywmW1IULQcZq8kweW4OW0QocIf8EY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=GSYt7p1g4bETO9d6Qq8Y5QOvEUe42ZM625lNOjYH+OOczlvKkSlbOn09/ufRp4XfZ
	 /et9W1u79/dBVZYfAdiSPWGbocL1uHaGz/HqQE6pSBs52GRUY3GnGJbjvwn2U53KR+
	 mRmemqbaug9is1yOMIsfZrrIaxPTY0pQk1BSvXgJpztqfeicGoY6TtHY96JD8YxrJr
	 i0iiy03mDtRx8apj5TcfPYGFP3V2yxoCmiM2j2udEh6YsjO3T3qGOL4nOMTB5jKxGp
	 WueU2FKz47+e9inVRGwvv7OgDVoNnwyqxy5Xf3I2x64EBU1Hn4CjVK8VMG8BrDsPuj
	 K4+GGYvegHX5w==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 59A716E02C;
	Wed,  3 Sep 2025 14:07:24 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250819131743.86905-2-krzysztof.kozlowski@linaro.org>
References: <20250819131743.86905-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Minor whitespace cleanup
Message-Id: <175687964426.808220.6591590873945932888.b4-ty@codeconstruct.com.au>
Date: Wed, 03 Sep 2025 15:37:24 +0930
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

On Tue, 19 Aug 2025 15:17:44 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '=' or '{'
> characters.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


