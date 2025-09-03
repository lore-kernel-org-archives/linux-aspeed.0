Return-Path: <linux-aspeed+bounces-2131-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BF2CA100C
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 07:26:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGvLl5g4Hz2xnw;
	Wed,  3 Sep 2025 17:26:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756884415;
	cv=none; b=iKhdfV+0IB4ZS2dmDki4MCzt6S5LE5v55JzhGXkUxTMwGUKhUDhcsdiou0rofyodBqilXX/ziwfdtNMUXhHVeuUbvEq05K7UZDciQubamSOz1PScMPfm/eVUtIWLPGzs8NOif4jDtCojSxfn2jWGTPbRwONQFaWozQjaduliWjFWKairxWfk4y8qKKR6vKeU5FNZQ/HpIMc0mozISoUoSMA2icQtLEhl0VJ9t0hdsr8GhW9PdKbUwqF70eP3Fa1XjikTTKrMhbd4G+Pjhqo+w/bd2NL5Imi4l/jgjy1FQ+EoiMXXaRhn446PJbJ7PCa5+U4bFYmmgR7tAMUMbB8ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756884415; c=relaxed/relaxed;
	bh=B73c6gIij7Gu6gmBOylUKaG4gwTrC9yCJueKMpwDFZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cfT2snCZxtrxK1FVjDpVYiL6pgoMqSW9KgNUWPTine7GPEZiQGBLxWpoqkGP444R9xpbEq4uknfRcA8GWYOpFMNSR9Fy1Glv4OBcpZ0NTMUz1symbzMOmguWKa9Ogku3QyEc3ijXVD0/5OUqne7w7T4m7whcRNIf2Pw4t2UQcSCOHciJsl4MvZAnTPUKVdfK+gzXzJ3mUN0lF+sMhkfu5KxrkyoZdDS4wQnsmGu357FboAoZ17xazf71ZCuVwQqQfzkHCf5CnvFlwIWegtASYNWixKdvGcpGO7LemBo9jLYWcbcCuUgLSO91nDuPgLuiuGpdTiKw0f8n2wCwPzWARA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aOf5SlQ2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aOf5SlQ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGvLl2Gy8z2xgp
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 17:26:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756884414;
	bh=B73c6gIij7Gu6gmBOylUKaG4gwTrC9yCJueKMpwDFZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aOf5SlQ264YuDbugUNcQnp9ITm3FW+fR1OtXcY1vH+C8DTn/fQhqFiVfVuG/VSx1n
	 FUsH3jFxrM5/Tk1/pjhY0nOxGio7ty8X4zjqrtcXcI50WjlCUI974zKe78nq+XSMjr
	 yvvWiugSF6MH80RvUzwN2eb2IA4yHehGaJFAhZf+IyvYp+bah0DjAO0W0Nbahb3YCh
	 FwsO7r0EVtwUX9RQabtQGcuqbKnyRuXg1z/SSjgne2RQRtARyNACsVaH09xGat8Cj/
	 oob4cNBE3JHUgxTug5nCvUwWyPoZOlm1ZmlIhbC0bchowqB+Zy+1wvE/kEouCgXjE0
	 T86W4x/Ni5NDQ==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0ED656445D;
	Wed,  3 Sep 2025 15:26:53 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250829211318.1335862-1-robh@kernel.org>
References: <20250829211318.1335862-1-robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Drop "sdhci" compatibles
Message-Id: <175688441391.934266.14858945902852809199.b4-ty@codeconstruct.com.au>
Date: Wed, 03 Sep 2025 16:56:53 +0930
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

On Fri, 29 Aug 2025 16:13:17 -0500, Rob Herring (Arm) wrote:
> The "sdhci" compatible is not documented nor very useful on its own given
> the various features and quirks of SDHCI implementations.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


