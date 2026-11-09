Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA03606A335
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=csfJhc/R
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNMYH6FC5z2xSS;
	Mon, 09 Nov 2026 18:56:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794210979;
	cv=none; b=Ho7rGYXEUQ7X1MlpWElZxJSLJE84sZRN5H4B+4h9EQqMexGLOlMGpHHhVZUcdJZ1R+hfM2v+Fo0AASbksKp+QHnGOgYFx/U0WqH8Cng75z4B8kDI31j7ApBqqI/pU6ivPpkSH5dK14xVQceXEZkrbZMB11xSNChj6YeqeYNjE5FJqdyF31ykzsuduMoh/kwm9gymYflS2J8yxlJtyCsAdS27ee6B1nY7PmMdtBuNhktHIjl6hnIszHRvRW98cD+jtTBfy5wTQk7l8xJnVIW1QX8PZ9XizvvtS8Am7xGkyTs2UZeGzjnPiGTALGszYChkUfPz3ZWgyNv7DJ6nJdXoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794210979; c=relaxed/relaxed;
	bh=beeIhfgcQV7TlBjZN1ejJeypNbQ1lSiL1HUsOsG1ZJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JxfJMdwz/vRQO7Y614GcFY5RYB9cfNDVr8/zqhOnJIQKBYOCc4TvqVRzacRz+lr/ZnLcTNxcOEKjx/nPzrsDTfz4i7U8fCCLRmol2a4HexFbJoAhORtqBPzUJGxL70By4y6EaGXVwUVulBmdAsHxi6N+NOfv43XlNX3Fg0M5PeeZLiF+TtMmltWMBkHsky7pUZ2wVObe39OAnPQ1vYViQbnvVIem3/JTrnD7aW39Xph0DNwBIFI0rMP/ev8tW2i7ivWOEKjI9Rleba5fiN1QXE7zrVwGmpHNycXTXOu4rgQCWhEzt25Yc8R8GHCtNZXRNE399SP/U8qMDGs8adW0QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=csfJhc/R; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=csfJhc/R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNMYG5rDWz2xGr
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 18:56:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794210977;
	bh=beeIhfgcQV7TlBjZN1ejJeypNbQ1lSiL1HUsOsG1ZJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=csfJhc/RRIoGZu7NmjEN/JlExsYIdCdDjKFGP0WrTXnd3adCSzQbtobaJH3CpJA9I
	 u+RvCSBmdHeUB9sXQNuzyFxnHpapWHIJ2XIttm1J8nas+c6Gl2u0R3rx2oQAC7jNhs
	 lUysmms+0Yj/NDFsZq5EisAgR3CMlnMfNeTl6eGUZ1AVxBo8GN1Fq24d56sX5kqcuI
	 KNn+acHpfiLjsn1e/Gs8OQuW+nIc+2OO/B19NI15C0rImroGXiMuixw0dXw3hKedAx
	 Foj9ZL6zIMdy6aUk+aGAReLEbqVl99A5bIPR6Hwt8GgHC7tHHMkZDAd5T3vD30pT9A
	 M+DmoNhnFGbMg==
Received: from [127.0.1.1] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B62156495E;
	Mon,  9 Nov 2026 15:56:15 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>, Renze Nicolai <renze@rnplus.nl>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103203308.54789-1-renze@rnplus.nl>
References: <20261103203308.54789-1-renze@rnplus.nl>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: x570d4u: devicetree fixes and
 cleanups
Message-Id: <179421097567.853200.13340616110295498836.b4-ty@b4>
Date: Mon, 09 Nov 2026 18:26:15 +1030
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 21:33:01 +0100, Renze Nicolai wrote:
> A handful of independent fixes and cleanups for the ASRock X570D4U
> BMC devicetree, found while working on OpenBMC support for the board:
> 
>  - Remove the w83773g temperature sensor node, which is only present
>    on 10GbE variants of the board and should not be instantiated
>    unconditionally.
>  - Fix the tachometer channel assignments for FAN4-FAN6, which did
>    not match the board's actual PWM wiring and produced incorrect
>    fan speed readings.
>  - Give the eth0/eth1 MAC address nvmem cells unique node names, since
>    they previously both resolved to the same NVMEM cell name once the
>    unit address is stripped.
>  - Add gpio-line-names entries for a few GPIO lines (NMI, BIOS
>    chip-select, LPC reset, hard power-off) that were previously
>    unnamed.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


