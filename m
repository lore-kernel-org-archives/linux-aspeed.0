Return-Path: <linux-aspeed+bounces-4539-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63239C44539
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 15:27:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4ym34Zr5z2yfD;
	Thu, 23 Jul 2026 01:26:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784734019;
	cv=none; b=ZXDqN45gn+hE/8sVunhkTnTlkdDXiMuZT829be439gOkMksf41aG7TBr6a/fA7+zqRoFKpXOkyHmlL7EOKl7qb+TIg50Ffmzd/vqUjRxlS7fBHLbCBMqqhmCTLk8QmqTjZHJcefed3dbeDRq+v4jYPgTuLHHRhAnTolEZIDCkRU540v25l5+kt3teEVQ25oRG6Qbmvon9gq0Rd7eUIUbGMKiTmQ4xaS0Hqb4+kUHhox5RLrltlu0TU26J3bivA76i4rFoCPB4HbbPS6jk+3QjZkMktEuNJbn1hxt7rfD9656w7jwIdKp84IO/EQWUt0Fw9zxkSm/P8/FI/VkN7Qt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784734019; c=relaxed/relaxed;
	bh=waIuGDxzOof05Vhn6AjjPmoLjfrUS90zPIn5MbLu1PU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ANNtSeuJdkuMblE6BIlhy8kr+khKHsN9Czf0v2MkzHdvLdv0t5SUTqNgRpNZ4XPCzJHZx1y0iBXuyk+6OyuAXXDATUjbEPGyl+4spPBLwcPItUHpdWHVjkb4Jh3Ra5bmL+S8CKSoqxlOKb1KsR+vQtH+aN0WfpW+nsiDw4qAYGw+p5VqCL1z8fKX97lgZvuRiUVYVTTFUCwEM/ug6uVa737DzTepDYKmQngTkqEnNyPU5hpMK0fCGCCb9VO+sxoxf1q7FORNpuk5TR+M6dHTwvVIy2RMO0QFQq6nEXII7yGwguT1Le6tsTQmbDfgFRZkEIPTa3ZUsFFECAzoIA+woA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lnCHSx6R; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lnCHSx6R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4ym23r7Dz2ydn
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 01:26:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784734017;
	bh=waIuGDxzOof05Vhn6AjjPmoLjfrUS90zPIn5MbLu1PU=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=lnCHSx6RJJJ/FNMGq6GCjXdFeUZFW9bzPLhcrXaf5K21B+BxKMAc1VUoJZDPvHn4k
	 h1Jf/kBPDawh3n2oXk1KvNNcbm9jpVHPqgdUkEwuql1s0xJijctTgmaKLYTTeJYnWt
	 B50j4tPhWLJanhtinsmYfKbnEORudQRL0bhPj9EjmnN5RAYpMqmcYNhnrmt3fUAioe
	 abqR6ClYwXtG2v+/kG+F/lgKCt6uEdOl8xVs4Uz85OCbIG62qf+8ECUSXH100tR/nI
	 y4/Rnt5hqxKKPLLgyBEUEjbBiIGr0zZCH6CF7Oc3qafgnmGM/bX0VwyDK/2m4D/TSX
	 4f/yIhcWArxgw==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 715DA656B7;
	Wed, 22 Jul 2026 23:26:57 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260706180307.635369-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260706180307.635369-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Correct indentation
Message-Id: <178473401740.1970914.2575839372513973839.b4-ty@b4>
Date: Thu, 23 Jul 2026 00:56:57 +0930
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
X-Mailer: b4 0.15.2

On Mon, 06 Jul 2026 20:03:08 +0200, Krzysztof Kozlowski wrote:
> Correct spaces or mix of tabs+spaces into proper tab-indented lines.
> No functional impact (same DTB).

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


