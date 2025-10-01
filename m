Return-Path: <linux-aspeed+bounces-2358-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A1ACCA470
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 02:42:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbzjz3GH6z3ccw;
	Wed,  1 Oct 2025 12:42:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759286567;
	cv=none; b=GuKoHtqb0SvtcERcM/V2Hpdptq/H9kdjr3Dcg/3OS68KAnsnfFrore8oAp6CPZcdolKzFV0dAufbiFqJki20J919IdQDs6e7Kr0WBhaV8gy5jXBOw8Iu5H2g4mFXjxf/zkDLdxAkVX8AiaAhMPetWmuYtknVw4ieUMPnOi3g/HmOGcW34ZzJuvYGZ8X0itPNULtYv1XyKBw8sZO6Des7dONqJNyEdJw+oQTPJZ2XyLoC1u068xMTxt9v+02o63Mt6jI/yEJlASA82BO/KcvhNk0Twde9ZHJbU10LeZYu5U9FwUpz2nUP3yl1e0GjDgx1wIKnAekaKh+lLmVv7gD5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759286567; c=relaxed/relaxed;
	bh=ZQ4G1nhO4fJCrWWO4BgcxbqmE8wNI73Tj0t3GM2e72g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MNn/dabDsuXLZYUUdJ9TT/i7OFuoscV+A0PczmBaMrEbrjspj25sj3tjMkzQxJRk+xDy6BLVA3ZZ/vi/7FvMb8yocsC1hvkaDoV/xMjRCzWMdl6EI+DLfmqUySVEVpZByrwE4Sz9/U2su9yF4lEtS1gkkcXSZ/nhuWeuaxx9kdswjCBIDP82Qz0mwOEnJUcIfRAcrXqomjPnfkhdUniXNglTxMf4FVYcdptrW2sWJsLbzw7woE++UIjvoPdsGF2jVM2BHpdcTPW5rtfsFlvmDHoZyqyv1Mn7HQ5N/LmJwvoCIaD3ZGMx/xvEEDuvF8tTuRANZu8mAWqCWe84nxcxHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZFBoXrmi; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZFBoXrmi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbzjy75J3z3ccV
	for <linux-aspeed@lists.ozlabs.org>; Wed,  1 Oct 2025 12:42:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759286566;
	bh=ZQ4G1nhO4fJCrWWO4BgcxbqmE8wNI73Tj0t3GM2e72g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZFBoXrmi4x46zx5rkn/TXKgnk88GhqVOBNlE0vpAngnzuswBVqBCuD8fygmxvJUbq
	 Zd+NhpkbpYbsw6adph0vkSqbB4wP3LkN/1rL6phz7FwuzrYY0ylj1VjpPOk8VR1StZ
	 xP3O0WVuX7WF40WFj1P/gV+lXT0ANNRRJFZlvzwevEQbWEHtzzy2K1LFqIMEoKTqEU
	 ObcdH8i+LgN5pzIn2T2SC5XVx2CJZFCvHsS/59pa043yFHkVBM6smC61lymxgFeC2p
	 yTpjv7sG/u0LM4pfwqd3hOQ0S5iyc4bMd9KA8RudInwK6pqZDYEhWbh8WsbaUJ5AHE
	 uIZFyalX0Km6g==
Received: from [127.0.1.1] (unknown [120.20.48.42])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A743264785;
	Wed,  1 Oct 2025 10:42:44 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Leo Wang <leo.jt.wang@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com
In-Reply-To: <20250930-leo-dts-add-shunt-resistor-v2-1-8712984f04c4@gmail.com>
References: <20250930-leo-dts-add-shunt-resistor-v2-1-8712984f04c4@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: clemente: Add HDD LED GPIO
Message-Id: <175928656396.3584264.16163298971652448955.b4-ty@codeconstruct.com.au>
Date: Wed, 01 Oct 2025 12:12:43 +0930
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

On Tue, 30 Sep 2025 10:49:23 +0800, Leo Wang wrote:
> Define a GPIO expander pin for the HDD LED and expose it via the
> LED subsystem. This allows the BMC to control the front panel
> HDD activity LED.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


