Return-Path: <linux-aspeed+bounces-1936-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8376C87FCA
	for <linux-aspeed@archiver.kernel.org>; Fri,  8 Aug 2025 02:00:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bynKW1bDjz30WY;
	Fri,  8 Aug 2025 11:59:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754618399;
	cv=none; b=IhgfSyvnV0rFToA33dYgPPU+wxWYLoB29CEnQlPLUkMkhz1UPkHnl24Z0yNgLZ0Mq6/u+ncphTjw/YTlxQTtqHk1iO8heOpE8J0NBwbWvHYr7JioyIsj2zVMzZNoU3EQQRdY21TSXN7KO/xGYFbTTkmFFiPBQdP53a4ZMkkqHOZSm3qoJZoOXQ2vVJ+zyrIb4+BULVVDTqEtStP8DHYfTR+L6PqKJki/xQvYH7CKCgjkHigJWXjUrPGp3AEpaECO4xjtJZEXA1vtdEKKQ9R7aeCwoFgHi8+kDnwLrOd5zfKwen5miMu2PC38j5BFowi/Nji972PT6bgjIceSty/J0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754618399; c=relaxed/relaxed;
	bh=q/Z5CMd8EqF5C3UMm0RvWAXOy10PzdDqowUayHDZKGQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ggk4ITYAUdKSmhPZ4/XTtWAgRgnruXlpOdbvluJVecewT6EcfDEuR+iK46/KXh73ervkhEyzCdBSRoClVptbcSKwq/Va8E7Nq5I/zRubUqPMI5U6sJBQ/uPEmKrZ0Eg4ufUNwTUZGib4hGXfL1D+4S6ciPe1cXDffCCYTtsFbj8vMZO7KnFv2K/HDYTFqI4SCD31sFRUeSbP64K4joaMfOMB5oA9WGrH3Sz2oLYkGurN/G205NsubchNVV/ICMUX2wwH8syNdT85OqJWuTd+tt6TcREwgVKuhRDa505Umvwo2Lo5rISNXiVaYs3fpfqCP5GwqbtldHjwU4/3/lMJfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NylGELSp; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NylGELSp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bynKV6266z2xc8
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Aug 2025 11:59:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754618398;
	bh=q/Z5CMd8EqF5C3UMm0RvWAXOy10PzdDqowUayHDZKGQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=NylGELSpdyLnmd+nk3zp/3w2Id/y8sk1xJZFnSo66Uj4i4pjruofrsSIM3teq513s
	 Rok9KjpM0wARz2r8uJmRct/edZoHBforpNC4l1k1FvSa/Hk7S9DQEm6NSTYXSj9GFo
	 10v19Io2DyYpe9FuG/rxgDfi4l5YI9n4dLkHU9ybLW0BOAIlj7zTBBzQo8aDy0apZa
	 FNdwYndbsbu5iN+HSgVmqAdBVMc4nrch7VXrxEORfbv+ncZUZcVlpzt+KqQKKw3G7U
	 zJonrGny/ZmP/3gguqwylkIwwKq1ye60LaJHID4EfzLI1D6uhoAX5r0CSvU+7rd2lN
	 rsk8lssptzd9g==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 02D7D6D59C;
	Fri,  8 Aug 2025 09:59:57 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250807005208.3517283-1-ryan_chen@aspeedtech.com>
References: <20250807005208.3517283-1-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v2] soc: aspeed: socinfo: Add AST27xx silicon IDs
Message-Id: <175461839791.140589.15788299148211671960.b4-ty@codeconstruct.com.au>
Date: Fri, 08 Aug 2025 11:29:57 +0930
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

On Thu, 07 Aug 2025 08:52:08 +0800, Ryan Chen wrote:
> Extend the ASPEED SoC info driver to support AST27XX silicon IDs.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


