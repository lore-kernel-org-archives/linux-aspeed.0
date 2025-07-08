Return-Path: <linux-aspeed+bounces-1668-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2528C83F0A
	for <linux-aspeed@archiver.kernel.org>; Tue,  8 Jul 2025 12:25:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc0gW2VNgz3bVW;
	Tue,  8 Jul 2025 22:25:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751977527;
	cv=none; b=PyTmx2r9INSnQ4tGStny/wYUXrXyM7Gx5P8RWoEK5tFnLL8B1JTLGcHzITkXtkfsXRY3s85/TA/DBM3W4HYGcFUsDtaaG7ZGnhmTVmsx2gTO+E/CzfB44sSFNddPKLGD2xpQ8zu5mQYlTiJoA4xoiUlgEIHSFLksy4GDJs3Dl9vQSPtqTxzwQbn8GduiUQdff0qml41KvJbm/af+SFAAGlm+6HAqkOe5Axhwt6Rk8Iix6fI2S5t5rGuhb3oeGedy9nOg2F2dmEUwtS29OALkyXiAfCkoYxXpc+fFpzeZyH7hZeL2rgVSZIJlIdf23v6F8fBHPm1NOU7d9uyg7LaCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751977527; c=relaxed/relaxed;
	bh=z/SZFPNLk/Jppw2vEUbzEfDl8Xoy/j7gp38uiq1v+Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihdOgKCpYl6a9/S25Ihs1YkQZHtjfc2meZFlfboZ3j1vPdchv2kuB7aMdWLUeu7vIa2anuDNj373icUKyQGi3zxotA7fMa+ym5zc0E8+0Lw2i3E2Rj3eBrIQsGwb4YDcEwasflQGEzU+/nYeTER/9IyZIW5+mbLKvBbN/+iIC0zAU1bKvUExUWrAmX+7tMmSdHFehCckDV2q6y8ovzPeP9MKAByLds8/tYVwZirZ0bbG42ZFfh4CrpgCKA2gVUEBeZIeJgQL6O6d9ml2381ZgWDpzDrNW0uX3MOZkzyGb8XUKP77IID/KXBWx+mvaR4X8ZHMs/U6mrB4S46MNkN6nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C0TOiXxv; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C0TOiXxv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc0gV094kz30DR
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 22:25:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F340761484;
	Tue,  8 Jul 2025 12:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70947C4CEED;
	Tue,  8 Jul 2025 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751977523;
	bh=cBKfOlm0o5tbUS+WeNcyTFJHeZh0VC1N9WvCHLT15mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0TOiXxvwLSU8dr4137SUIxZfFSq0bwxl4KnbJ/7QuXl0xLguO7lPlYRni6oBFBDE
	 hiMW8NUpZfLdCdHXl7bhc8fLhYFy+fS1iZDw5+cDmP6dNDa2uNkhjxA7dyJVbOlXMi
	 8LHjCb4XsEaoBupu/dt82pmoXwwtlbB4KNb469TIDOOMFeIQNk0DrHQQCxjVhHU+yw
	 p38HSukHG2+hMUoctkdLCXPsFC17zS90K/pdBfdMT5bGEkqgY8ZUavIVQ32VbgnT/f
	 Hn7mFHLD8WNY2AUiyQlS/jz9p/sryOx08NslPN4U09qQKGztf2KPhv7Ro/hDbDcwsb
	 6c8g/ZoE2fldw==
Date: Tue, 8 Jul 2025 07:25:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Leo Wang <leo.jt.wang@gmail.com>
Cc: linux-hardening@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
	Kees Cook <kees@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
Message-ID: <175197750014.297501.9917698963252838372.robh@kernel.org>
References: <20250708-add-support-for-meta-clemente-bmc-v6-0-7f3e57bd0336@fii-foxconn.com>
 <20250708-add-support-for-meta-clemente-bmc-v6-1-7f3e57bd0336@fii-foxconn.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-add-support-for-meta-clemente-bmc-v6-1-7f3e57bd0336@fii-foxconn.com>


On Tue, 08 Jul 2025 18:18:00 +0800, Leo Wang wrote:
> From: Leo Wang <leo.jt.wang@gmail.com>
> 
> Document the new compatibles used on Meta Clemente.
> 
> Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Conor Dooley <conor.dooley@microchip.com>




