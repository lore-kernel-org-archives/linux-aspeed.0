Return-Path: <linux-aspeed+bounces-2154-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79390CA1015
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Sep 2025 08:13:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJ8HG1CgMz3bhY;
	Fri,  5 Sep 2025 18:13:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757059994;
	cv=none; b=bK6FGxwH0ZsirIbJsgmhQC/AaBkccaat0J65RVIOHwKHU3IZSqUnCArjcP2bXHxLjSz/IgQiIavFUwsQaPLPwKVerMMWzAzmOxJKF6YkS9TFEYxGJmOJ7jue+69Yb95R8WV2HyQ3G/l2laSiUtUE1UBKuH3N5x7W7+SPLE/RlpRXJ37KOGXkzrJq1ucSBaL68R+0C52bY7p+MnNrqwly38ibN43Bg+j0Eutfaaz0iRwmuFTe+fDfel8T9KqKM8kpkm39V/NuDOLgfmmYSk0TH9bMtAhegq0oT/w8obqxXWPgR6iIwg9EUQohJ5BUV1swvTr4ikdpLpYdB3YCbGyXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757059994; c=relaxed/relaxed;
	bh=aOva2ua5YC0DlSsKzj422bisdd/KEYS4VnSvX68g38U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvGNHviCEYMD2N2fLZ5IqpnWVuk2P/SUEjIxNEeMXLnSt8d9j92JuE9ysBF1Dw/auGXUnwlYD2X71RjYZj64mLcCMnSE3NeI7G1uketOKJFfQMQKm0iYPlOskkNOdzyU5F8WrOt3Qnfq3Kg/yNAQ/bRzixCl/2OWrI/2xgVNA8B7WswkgxLbxNXyiir7LjnGwCfW55KUATkMZbLMc+1/SQpOFp/HmNE5zbGsyoRczR9OP3n21pzrNv3sVPIVcoWdZFlqLXVUldMx8jFXWrRTJin5nRDbeUUrH+gAfMJlGFHxwfv9z6d9zg6KUnNUT2KLJD1iI/M0Fhk9c+YaGLn9Sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uqfTjSQi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uqfTjSQi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJ8HF46Y4z3bh6;
	Fri,  5 Sep 2025 18:13:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 534AE60279;
	Fri,  5 Sep 2025 08:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF30C4CEF1;
	Fri,  5 Sep 2025 08:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757059991;
	bh=S6kWmIW0hVTEZZAoAewWz0JxbYGS//J7DbVnzoq7lWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqfTjSQidjTXugpGnslEzU82f/RadZElrGPTahUGa2Vj5cKM5BL5TuFZJyfNoVThP
	 cXJqvvemUKZHUrcqJZj7S+nU2Mt/FOKD+ANHVUJDojYsr5/k6McPz32+9bHLye4urn
	 1YvTNlTZ7ERiS/E3Q9h0TGVAo5cOi9RH9MY+eUMzyfVSeziJqjw93A3IIQ/qdHRK9U
	 gm6OUCPSqji0ceFUTD5F2sflO21MDu6wIywexM4+gWmryX0aOhjgvVx2k+jpjZ2CGB
	 dGnkwzASq7uyDcyrPakuM3WTWOS4lD5GVXOsqnJA5sbDKTJKhFkuNxRCnkvQ3cfDX8
	 QhlCb/hGrMHrQ==
Date: Fri, 5 Sep 2025 10:13:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	linus.walleij@linaro.org, brgl@bgdev.pl, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: aspeed,ast2x00-scu: Support
 ast2700 pinctrl
Message-ID: <20250905-oxpecker-of-impossible-prosperity-63ee96@kuoka>
References: <20250904103401.88287-1-billy_tsai@aspeedtech.com>
 <20250904103401.88287-2-billy_tsai@aspeedtech.com>
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
In-Reply-To: <20250904103401.88287-2-billy_tsai@aspeedtech.com>

On Thu, Sep 04, 2025 at 06:33:58PM +0800, Billy Tsai wrote:
> Add the ast2700 pinctrl compatible string.
> "aspeed,ast2700-soc0-pinctrl" and "aspeed,ast2700-soc1-pinctrl"

Nothing improved, completely redundant commit msg. We see this from the
diff.

You got comment last time and it applies everywhere.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Best regards,
Krzysztof


