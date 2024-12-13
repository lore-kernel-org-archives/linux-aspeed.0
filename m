Return-Path: <linux-aspeed+bounces-223-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FE2E7717D
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 09:11:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8k8j4zyGz3bP4;
	Fri, 13 Dec 2024 20:11:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734081061;
	cv=none; b=ik639WTADijLUiPDM+eEx6/5Zq79bC0VlsPuHLQwEkgCXY/k41zKOPXwIygAyrIv58J7EH+ryJ5WzYzA1fEveeDKw0d9YfFesa+60UwG+5TlkXttF+evg2Ye7NQlpMswK0jImERAOyuJHB758E4ZN3J+qfpX1MWVKTd32As054I62UTu7jhYeU2Rf/7oLLhUPNaRP6QIIm6qoA5RrE8ZP306s4WTyRpmxfRKe+suiR36xyhAaGpwIQVtxXBYXXdScXjBhKkyeKc6sfj0C6hpF7e3wCE7Xsgfn5YSYUDn4/1ZqVbzNC1OJyfylt1sJls1KWRGQ8aHq1cRpYDpOJYnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734081061; c=relaxed/relaxed;
	bh=rCUFAByP9cVuG9VB1K7M9sg63VdKSoihxlYcF6Tvg8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMiqqFhpVhJoGba/ggwLsu2e/TZxsgHUEDb/SX6wZvv070ZWPOeVlHNNzggsOsR5nyLZF8FYY/Hje9BanWGpGPTbnwvUEnQK//RM/qjB/672+Qa6lbKF0WvMLR+ZwV7b2LCS/Dgv/7UvSFSctXMd/FxORjT73e+L98ABjO+Z4SNUb4KoVmt7aCheCrwTLrj+NZ893r0oTQyAeIK2HYPqIw/WNBwv0GwiOBe2jZu9KfAbDE5KPAx+eSxSzptnENdVA3U8Agz/r4EIXxh6g3PnNAhP8S407BL6uECURrWbGYpCBqjBjtnz9Au0/Jv2bkgaWRzNCM55Hq99+RwzuoEmAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GAbwKM7Q; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GAbwKM7Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8k8h5CFdz3bNh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 20:11:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 49A37A40E0A;
	Fri, 13 Dec 2024 09:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5358EC4CED6;
	Fri, 13 Dec 2024 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734081058;
	bh=G+cTnuuCPd8OUrWtJFXbPhKcg/vWEnCq2zPfc22GuSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAbwKM7Ql8JlHQtvaxCAEjlrWi6IlQRqnJA8CZ04DwQrSfcb10h5+6cjzhldotnRh
	 L2XSBgnBNZJUfO8crBg8MZlN8CfTvAifyk+GlvHyJiBZTVjivci1Qq01nMnxglh31v
	 zi2eIA2ZMTu2jG9TIvc1Ivn5fZM3DHGSFcpIq8o1+3NB7mQAtUoaY5nAKzecFcPCyO
	 J9jow5Rd3wWUjudv+BGCRohLkufEOp6fwOe3r/hPcHfEjlJ+YXmMmxWIju6dHjvMhR
	 Jw4Xke+387YftU3lGl/YoX2Xk+UUsw0Rkspn2qa5yOkvs2yO2Ogw/NNIThpLB0r9xj
	 +Wc8vdUS31j+A==
Date: Fri, 13 Dec 2024 10:10:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, tglx@linutronix.de, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, olof@lixom.net, 
	quic_bjorande@quicinc.com, geert+renesas@glider.be, dmitry.baryshkov@linaro.org, 
	konradybcio@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine
 size/interrupt-cell usage.
Message-ID: <k7jftzlih6ss4yaxrv7r4dudhcu43iyu2qvkl2thb5wiaszto7@evzmwfxxzzt6>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <20241212155237.848336-3-kevin_chen@aspeedtech.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212155237.848336-3-kevin_chen@aspeedtech.com>

On Thu, Dec 12, 2024 at 11:52:31PM +0800, Kevin Chen wrote:
> 1. Because size-cells is no need to use 2, modify to 1 for use.
> 2. Add minItems to 1 for interrupts for intc1.
> 3. Add 1 interrupt of intc1 example into yaml file.
> 4. Add intc1 sub-module of uart12 as example using the intc0 and intc1.
> ---
>  .../aspeed,ast2700-intc.yaml                  | 60 +++++++++++++++----
>  1 file changed, 47 insertions(+), 13 deletions(-)
> 

As with all your patches, repeating since v1 the same comment, so one
more last time:

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof


