Return-Path: <linux-aspeed+bounces-2570-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A68DCCD1BB
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 16:38:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csFG83296z2yFJ;
	Thu, 23 Oct 2025 03:38:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761151088;
	cv=none; b=FxaQ0dKzsAEh3UjeBAmNNcmYJOmFyxgHkuYy1OZjuHEvWx/cxZHmzGTah5zBJI5UPke8dqTNV5zZjQWSnp8M5DFvLudZOBx1UYVcWfgHaLabCs4yWPX2FOCIeVsikpb3biaXL6vUbYbEqiWGPmMST9pZn3tUGonKTpSJVG0ZUamiEi3kIfyEgr2M1gec5DLPfK0Qtk6kGHDiZoj+Bz9pOhr7mREneGUk8Kv7pnasYaQJEq7WYHoxlVPhHVz7CgDN0K8IPVIds4hFsEauMTEqc0HxBLvAAjDtpp457wZ1BbiOqXp4xJzne96Zi7/0sexPcTiIcXdS7oy2gKHTD3dGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761151088; c=relaxed/relaxed;
	bh=V87oGT85aTQasUZiMJWRE9RqxAPo4aSgAPSUdDURqZQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FgLuqj69VBOYeza6GoTxUkxPZc5YbTRVGGI1ZSv2T0cu+JEZMmPsAc4tzndbRINFPd2TeOCt2oaCYu6W1TZKNZA87zdrOiX1DksEGoHG4yOZeTTSJiPdRtnc+25d95K/MmrtAO7KqpCZMpJouJeoY+zUKj0FkG37vT7psd+0rVjg0CKko8xbmu0S+sln00nAvQMioid9k3LukTz+XtHZrwPTPBO9coNSV19o8r97670iRjgxr92G6jLSjR1gAJB0dRGqk/dNh/47uPHVu1zbdeSVPeqri4Pgmjnq6eHkiGiil5lIqNX3TUgZAZh53i1mYV8Pp48whrfLeKKxYXerVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mPRAYTj5; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qbLYTF8r; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mPRAYTj5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qbLYTF8r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csFG646VSz2xnM
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 03:38:06 +1100 (AEDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761151065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V87oGT85aTQasUZiMJWRE9RqxAPo4aSgAPSUdDURqZQ=;
	b=mPRAYTj5Dh5mX2LmMKeKOiWNLWNbqx80YIoWu0l7EoQ32Kfq6IKfmOFNuVWEl4sUCCQSI6
	FfPLpQEkRP1itkSSSCc5OevgONypSd9l+dPPIxDdtquwcPyu7AHvo0L1MAmnBDG7ZbP/vy
	9FRUyHeip4vpfBxyIdPWpbdi4PENYp/lX5rFO0I1YGs4/F1CE4C0pmYxCQJDzv3oxksXLa
	gAAKGHSv1HGEgJSWWMcwNL6fRGTdpmvY9CChW36CMDmmsjN6TbID3MXK9vFwAcOwhULNGF
	L4Hzaxig6uU6knf55KonxnE0Tmcazzn3/WufCXusTrNB4DDwCdPcifNb/GJN0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761151065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V87oGT85aTQasUZiMJWRE9RqxAPo4aSgAPSUdDURqZQ=;
	b=qbLYTF8r3Oq/U+GMSjoIWBCyfCVvQ4zGZBagssYSDLcjHGUUgAQJRgfPHtENijbJuGqtRp
	7gjIWKyrtQEo6qDw==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 jk@codeconstruct.com.au, Kevin Chen <kevin_chen@aspeedtech.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v5 2/3] Irqchip/ast2700-intc: add debugfs support for
 routing/protection display
In-Reply-To: <20251022065507.1152071-3-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-3-ryan_chen@aspeedtech.com>
Date: Wed, 22 Oct 2025 18:37:44 +0200
Message-ID: <87h5vqyjs7.ffs@tglx>
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

On Wed, Oct 22 2025 at 14:55, Ryan Chen wrote:

The prefix is: irqchip/ast....:

> AST2700 INTC0/INTC1 nodes ("aspeed,ast2700-intc0/1") not only
> include the interrupt controller child node ("aspeed,ast2700-intc-ic"),
> but also provide interrupt routing and register protection features.

Lacks a new line to open a new paragraph.

> Adds debugfs entries for interrupt routing and protection status for

Add

> AST2700 INTC0/INTC1.

But what you are failing to explain is why this is required and
useful. Just adding code because we can is not a real good reason.

Thanks,

        tglx

