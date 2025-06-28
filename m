Return-Path: <linux-aspeed+bounces-1599-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C500AC7EE32
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Jun 2025 12:05:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bTrjJ1hTfz2xgX;
	Sat, 28 Jun 2025 22:05:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751112340;
	cv=none; b=OSwwJkDFyu3XLez1r2M/wzMJsl1fTWPQ2YIKi+uQPdfdXfpQdupqSfEPGuLOc04dYYYRo6n55N+rK+wCz812UDluRJl+r+XAWnLtNr481yDhaqbl5MU3cX/z2MLNmZq3OD/Am6z1l177fQhSXexDS781CkHZ/LXH4ubRvxuW5UOLuGHH1Rjj5Op4OF4jRocdzlrZs+dKERDrV4z/JT/SRWySKUy3xpM4JeSTajFV3X9OXAO/BXa3iEQ0LxCbakK5Np52bZsR0UtRogGXXu4flrW1hUfQqSmoLH9b3L7K1rlBHySHof5LPlkSCbeAR9DO8x37xVJHer0uu18m6r1aCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751112340; c=relaxed/relaxed;
	bh=FOKxrsqb2oTs8K0Qs4yW3KUDYy/eQafrIAqX/JO7wOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du1F+J02SzL2cCV+kHuqUaaV6tFxFab/QAeCpOgnmv9Pbkrk7il2Lqfq/9GHn06EXFM600LXLkIMLriJz+VRQeHls8hi0n7CZQk/qq3WNNCMFqPZ/Y3L4rdJUt1UVZBdlWxIYqJKrVASGGopBT76/E/EXNfMdcpyyvBgC60I6tOmOAsv8iMW5aeSWN0+TQMry31p3ztpGESOaA7KWhBY9TJqsG5Ly0s1oH1d405Dyq3WnyxLus//kHcWZUv7uI4qRYEZMr1lmAnccQ4cY7hZma+f+1efJ0IlYTzAgXHJxHpAXau2OcdUlWL1Bx0L0zh2DFdJXkoUwghv59tJ2j1g0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jlBSfVn4; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jlBSfVn4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bTrjH33rvz2xS9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Jun 2025 22:05:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 135A95C4A97;
	Sat, 28 Jun 2025 12:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23FCC4CEEA;
	Sat, 28 Jun 2025 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751112335;
	bh=DttSR+loL/+XwutcRtElHNrAyAfQKYpKcvL9oh1brpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlBSfVn4ePgI4Y+1FPzDgHJ46C9P1SILP9iSnzYGnpProm9sYoW/Yfz0dZEYBNbLG
	 7xgr7rsmMVS1iP7E41jLMCefzSJ3nU5xYHvsMiVAIDmXlJ6IB9hwW22YNfTPHErpDP
	 a32lkyHkTYoUfFxN8z8ahdTMvan7bAzFaCBh/CKxLsRX2kMdzQc22oBpkWFauji0SX
	 Pk33L/NS4Euj4O3DueYOGBFQrudskK+xJEIFuu31f0F0J1pLc3x+o1KNtlEySNB2FN
	 xyc6ouX96CcQfC+WsPLz3B4jZTht0jN6ZaEoZ0TLzlJkJ2T00KQGK+JNVPEgUUlfdt
	 AJ/oKPUIY/nug==
Date: Sat, 28 Jun 2025 14:05:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leo Wang <leo.jt.wang@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
Message-ID: <ojyrhi2stm7q6kcd7yl3je36cccbzypsepmc4fvl7venynyu5g@52rs6bntmnwl>
References: <20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com>
 <20250627-add-support-for-meta-clemente-bmc-v4-1-ce7ff23460c4@fii-foxconn.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-add-support-for-meta-clemente-bmc-v4-1-ce7ff23460c4@fii-foxconn.com>

On Fri, Jun 27, 2025 at 10:59:02AM +0800, Leo Wang wrote:
> From: Leo Wang <leo.jt.wang@gmail.com>
> 
> Document the new compatibles used on Meta Clemente.
> 
> Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>

Checkpatch warnings.

Best regards,
Krzysztof


