Return-Path: <linux-aspeed+bounces-4533-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D43FC44539
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 12:55:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4vPd4sTmz2yFK;
	Wed, 22 Jul 2026 22:55:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784724949;
	cv=none; b=n0nHTeONLGK08Hk9KNsC4mRQOE5KdWFqLHktykhrWnr1OraQaaWIBCuONW5lnRD2la+cEglf3KulwJsS+xCeFePVX5L/Dpp7Yd/6pgk5VSAZq7RF25QCzMt3VPX6vGmX1wWM290CBn63vaY4puUE40Rl30K9amN/kmjh04mSoe1czcXLKBynIteWtPUkhONv5BcsdPt/yxLClMDd7Z9oxRbUPqcbMuSc8KhfigQLsiZurJWhjNz8K5nbxpn6h0k947MGIM5UaemHWJzGyNEnjOnlLgTrO+i1sAWF+3H6LhVE64sjZa/EFh+AMQp9Dqax/hZddqxVZ+8gXiw5pdQcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784724949; c=relaxed/relaxed;
	bh=G6KtQB8gXmpZAqNGs3UWEl+Qs096uPKClugnnWz/FLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UneY8RRzMiWn75oEs0WWumItbOx27Bex7rchQxuoqSL5OnvbwQDHDWqEseNdL/DPOdHBvdu2TVUy8nungG9kqtcmceE9/xF9uL2sTSMuB/miw/UzVXJRDTeOStK/9OGmQn+PnYyuXhDGH5AVWMn1GCqlICxkAWfP+QKz/0qJrPWEGlyu26nSVxnZEblR8TM7Olgsz+Vmh+ZvkqRfPbBxoz6GIleTpsdB+A5SKhQfZvgkGmJa3W/+kLY2Vf02Uv/vSGPCz1rgCj1iSjE8VZHU1Jk+mFys+zIN5rjQuSr09dI/0+0veGEQ1trRPLq1J4LwUu1mwAeeHL60pWOZwF8vwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RnfFXsNV; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RnfFXsNV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4vPc6l2Bz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 22:55:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784724948;
	bh=G6KtQB8gXmpZAqNGs3UWEl+Qs096uPKClugnnWz/FLs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RnfFXsNVNa99zzvS8EqVEIZrIY27uRy8TQ1Cogx6jxo1ZZYp+PNP1dXo7lhmKShjw
	 4HF/wqKDCJXXShc5GIqJF+lw/k8K+R1NPyY0cuuuR6/on+4UypajEVit+bP5zwUkfz
	 ciRoa5CEyWKdt5AS9llvpTVZkJX7jFe3MhaU09qEfHBa+mrzvlUgq1wIH1Yb909/QF
	 aEehhhTqUY8MWfJ+tE3v/v8TnEPpQT15IywzOkV6UCG52ZXTdxPL85IQAuKibaKy0x
	 kFoR8zuqwvAoSAZiJ0+aSmAs8W5qUd6+4R9vI0wKjIdUD/ddZz0owx8Dz6rv5DhPGE
	 MLn2MZnIoOMDQ==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B2B3F662E1;
	Wed, 22 Jul 2026 20:55:47 +0800 (AWST)
Message-ID: <5333a3912656d4c85fd063dc5726106e38150ad6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: g6: Use KCS AST2600 compatible
 string
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Haiyue Wang <haiyuewa@163.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 "moderated list:ARM/ASPEED MACHINE SUPPORT"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/ASPEED MACHINE
 SUPPORT"	 <linux-aspeed@lists.ozlabs.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Wed, 22 Jul 2026 22:25:47 +0930
In-Reply-To: <20260627052708.172918-1-haiyuewa@163.com>
References: <20260627052708.172918-1-haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Sat, 2026-06-27 at 13:27 +0800, Haiyue Wang wrote:
> As the commit 2596f6b93a60 ("ipmi: kcs: aspeed: Add AST2600 compatible
> string") does, change the AST2600 DTS file to use kcs ast2600 compatible
> string.

Is there some other motivation? It's been a while, why now?

Andrew

