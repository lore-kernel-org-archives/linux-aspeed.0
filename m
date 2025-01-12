Return-Path: <linux-aspeed+bounces-437-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBA0E77188
	for <linux-aspeed@archiver.kernel.org>; Sun, 12 Jan 2025 23:51:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YWXGX5S2Jz3041;
	Mon, 13 Jan 2025 10:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::2c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736701882;
	cv=none; b=P9NP0/Y4vafW2CkNBiWNG27zDAFINOG5vhkNnckuQYLwZasqVQM9ePTZ75u9opSpY126dA10Q/EcYpIpnVTjOaYF51Lk08dIfFh9j6fd7BM3gkLnupcaKUcR6B1M2Nnzxxb65jTyBhMU+Lc4SpZQ7/amrh8wXXiXodqqXOMJZXKHEMMsX1gwCt+COvjYnTeKrt3BwiL4PdsJvWiXx3Whp/Zh0oQD+IeQbNHOUmGJe2eG2GMJf7GT1MxhYPCOgBo26QmIyt0tZ8hboBa7D7XnFiScxgPsb75G7qPRqRYr0C6YtQsjym0XyygSf13nF58DNO07mD02hdWorEK/1kz2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736701882; c=relaxed/relaxed;
	bh=BRSvG4lHDviRuzjJRGYuKFbYzwOqYOzJbZ32m62ocNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffOthFl7FILmy5wlHSQcyWeS/YWbpqKyWVD97mPZAnc2/8es503eErR4nImqu4wjY+AN6FcY5GrQXItOx+epjPBgB9hv3DZQsLp3t61WKQEMo7JIpE9JXGgr2RFKVskAu2j2StFLyBBUGCNCGPsLjKdhWC1KgOSg9OKLwUuf+CYjqhaAGDPR5ZJ1PPrC4+LFQkWArm7UzffT91YwKgqHYmJoThgCvP4JVtFA81K+7WRyim9cvb/eh8TZF2OHi3H4D8IWoCQqnn0210zvc13Eob4UjAh6ye6RW18KP68jQAuc3De2Ibn7obmFMo2Tu8LtxiiXJPt/1llFlrnIgI+auQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MiIY7gFv; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com; envelope-from=jassisinghbrar@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MiIY7gFv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com; envelope-from=jassisinghbrar@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YWMP41Wqjz30VQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jan 2025 04:11:19 +1100 (AEDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-29e5c0c46c3so2020139fac.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 12 Jan 2025 09:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736701876; x=1737306676; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRSvG4lHDviRuzjJRGYuKFbYzwOqYOzJbZ32m62ocNE=;
        b=MiIY7gFvq8R6DH8wfISIUACREUpRGYjSwxMogjcjK6WGDjgnSVdRUjmKQVFEkq3HwS
         e47ARWi0QKmJoXQEQsUH+EtTYLbzqJuCJjD/JQZZYnnaG3HWkg1ZLHg95CMOVCqkvgCB
         gKgGYqCj2gby6RTqxzahlhTonfPWH2K3grsSXCs8YolKaR7j0I6wI3xUJGY0XsVcyaMn
         QgQdMJrYRpTUhbc0puqf9W/vuH4/Y+SO4PL+g+GaYjPTBUnC51K4uJmWhMprc4ub/qeS
         QerpVnBsvkJeWBUxNqzLHEh8e+kit5RsQBITnfoHOO8qe2YuZW+4iT8ZSlAeowZ4Vy3n
         /HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736701876; x=1737306676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRSvG4lHDviRuzjJRGYuKFbYzwOqYOzJbZ32m62ocNE=;
        b=viQ+JSvezDCMGTpIP9bHqW7pToCQpPWUlwM3nuG3SaB+B2u0j041fVk2QbseLe9o3S
         c5pre8hCn7N0saJOPbICvfwMv03I3E3HKJF07rb3n/VjvS4XtXTjuDz3PTH+afWMoYnZ
         DWY1aPnCnV3mcWF3RbShkIVkTvN2EgPl9kUw9Q41sKoxhmYNW+c14O8bdvlNeLUE3Qmx
         mfzjrmHAuAUWLnt7FyU3OpdD/AEw5UmEbdRVMDHAwokkBTSebOzFN0Kj8mwioF3MUYqY
         X46t5+J0u+LgS/ltyGNNQoW97+N6QPS+URw85+OE6FgkygEEG6Ff9KR48keVL9OmDGSP
         7VuA==
X-Forwarded-Encrypted: i=1; AJvYcCWR2HDzm7FIFRatLEBQPbWgBMVTrDRHda4GXOclW4/sLJAjpatVNZsqIT72/vBdfmIFShnejROPfUopGkk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YznqLTmvqMmU+bnoyoO5NRhKgu+FIBk/snLPCEfbrTvg+GE1WK5
	rwTN25kaa8bLtST8zoeSoNbPNUn78AAA5u7uc8xhK3uaUho0Oq0Prt1ncJUpi0kKmrLIWBrYrWZ
	EZYDELbkphDI5cuVwqhH0+YX8ZSI=
X-Gm-Gg: ASbGnctbp3t+UlLghiuDBeLYGQrgUgQ9BgwengvPMLnziIwKO+Zr/XKo6KAYe+fvKTw
	mpdAwnxuWDD7upfp/vYAfRFxMReziMXJsXGSFHNs=
X-Google-Smtp-Source: AGHT+IENGjLXxXcSGe+w7tY3R64tOX7yK5WBTBwurxfDdtVFwVvG/FRtTErahZqTGTD6G89aj5oqyZiB1L1vqwlTv1w=
X-Received: by 2002:a05:6870:ad84:b0:296:bbc8:4a82 with SMTP id
 586e51a60fabf-2aa0690e4f6mr10712332fac.27.1736701876276; Sun, 12 Jan 2025
 09:11:16 -0800 (PST)
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
References: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 12 Jan 2025 11:11:04 -0600
X-Gm-Features: AbW1kvbXjyqTnf9gPwBQ9ZLkKzxPws-DMkCbBAzJp--cshKBewoVPRLg0dMWqYE
Message-ID: <CABb+yY0sgg6-zF-0shQbcZ=TqxYGDO=S847WpLGFcF3Xh9f2Nw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Justin Chen <justin.chen@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Benjamin Bara <benjamin.bara@skidata.com>, Bjorn Andersson <andersson@kernel.org>, 
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Del Regno <angelogioacchino.delregno@collabora.com>, 
	Tianping Fang <tianping.fang@mediatek.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 7:10=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 40 +++++++++----------
>  .../devicetree/bindings/usb/brcm,bdc.yaml     | 14 +++----
>  .../devicetree/bindings/usb/cypress,hx3.yaml  | 24 +++++------
>  .../devicetree/bindings/usb/dwc2.yaml         |  4 +-
>  .../devicetree/bindings/usb/fcs,fsa4480.yaml  | 20 +++++-----
>  .../bindings/usb/intel,keembay-dwc3.yaml      | 30 +++++++-------
>  .../devicetree/bindings/usb/ite,it5205.yaml   | 18 ++++-----
>  .../bindings/usb/maxim,max3420-udc.yaml       | 28 ++++++-------

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

