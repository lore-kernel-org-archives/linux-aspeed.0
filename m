Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44374606A337
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gaeUGAg4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLPCB6phrz2xJR;
	Fri, 06 Nov 2026 14:03:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793934230;
	cv=none; b=LFyYYYyGI+hjhtx1QpMrLnyir014R2I/rEw+IKks9cbP7nYUFqfs2HnwY+s7ZJLguY3WgroztsLQrGmmtx1nVp60TQFzab+jHfrZNQfGho5XfAuzFexj3HeJESo1TzsqjsHIzSCOqnfVhWCYdu8i/LiF7VPEZBBFMbz5dYfOKwOBMBaqmmSOrV6miu30YDQVvmBbub8aEcvg5IVAe6uA4e6KzAIxw/Y07ZfC9joPcYHKtXP8RXn1eqi0Tu4ya8ZQSWw6viksnvYN6XISXPq6fEqUjV5ALp/2IgoM7ci2k7lk6I3N1atEsmXCzBbyhjFR3Ao4+LB5/ropme45tSuI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793934230; c=relaxed/relaxed;
	bh=6pgUzHBMcni0x6QQo/FZyS4Wix+7yma0HG0CtbjYw9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0bq6wJjYBNuNTNJ7XGI0T7dQyvn1RQ/p0la1E+d4IbHawhRt7HQ55wTPXktjbuXlCcksDhY+nzRkj19NiDfrHqCIdIc3OMNrOxVJRXkU4kyghz2TGmy94Jr56DaTTrNKjW6hj5uD8GN4vvGPi/qTc8dx8pfD326G3BhSGCd5yvp6bFLtQ6bjWxKUtIlsBP1WbIoP8b175ku3j60eCUpuqZM+iE+2RtEolpMursq0Kvsh6NdoFQR7bl89SGXaSfR3Y/09k1S/HmU4wcxoZceiCUQRUiRvYg99yBGCPMJO7CbLx3zhn9lH+EOJPipXuCymeTvz27Q8Fb9Sn931NE+Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gaeUGAg4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gaeUGAg4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLPCB2Bdgz2xGr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 14:03:50 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2e98798cbddso818985ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 19:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934228; x=1794539028; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6pgUzHBMcni0x6QQo/FZyS4Wix+7yma0HG0CtbjYw9s=;
        b=gaeUGAg4qB3mAE7tGSc/R/TRe4XexAe/g+3XnexLexq8JoSleuCqMqd7Hw3g3kgcc1
         sFmkzQTTL0FGPKZu++ntKqJl2WGONQvC56F5ARS9N7hQalp8rvhupl8G1k0Ck/schEYP
         FEB6vTVgD9W0JOBox8QTJ39h1PvEOpjGZmLyJW+3rxzyDj0TjfFsXrlcHpvJg+zVoevi
         Mz3g16nJLfrqcEQAsTwO52kyL3Ontx9wJHeqLf0UnilRFusezThvQOFMGI4LGzqyMNXx
         qtZdGt8QHj8vMQMuT0Zky2XTDZ1E3DGkkRNn7ZHJJ7FFQwshcx1q72WhGBQhA+TJMIEG
         nQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934228; x=1794539028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pgUzHBMcni0x6QQo/FZyS4Wix+7yma0HG0CtbjYw9s=;
        b=qqwQPHR5iErDkmkXkCaS71H88Lj7TQtNB12eCOdFAaru9TVI6gvjniT+laul3SayRD
         eJ1D0lyjWX/eIeGUvkKCJuovmea5cL53zpDSI/CWk/Qw5GUnJFvMtahZTnPo/hmiJieN
         UcEi0ndnVnSoj2fX3f9gXZpxwtbU6C+A6WwAE/uOJ43vxEdEGPu6HAzNaa7jR31vlJE9
         nq1HezA7ezg7FQSOaTGBkC/8YxWMIYMdnyRZa7GIebhliAHFnaQSI74rRcuYnsWRLVKT
         XR5phiaX2NBdJHNVKl+eB9TmZdtX0X50z4Am5VnOft6yh5WgAo2/TgHR9bvuQNxIv9mb
         xZcQ==
X-Forwarded-Encrypted: i=1; AL+hErH10+OVPKEv1zpOMBDMeVm8DQWiMiibJSZ2aKesk54FQnZ+yiRCVCxWZfvoHTcUataRRUBrlQGpBtIYYFw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9tKKpzv0QjdJ/0z/SHi1eeFuNs7lHVRzOuw4BLFbAT8Ji7c4gx
	PKZCz5FlsK+F7LXIejFucLyzNULH/egLy6xDX89kJzrkcheQyEx1IriY
X-Gm-Gg: AYBFou2YCgeyprz1maMPT1BmNkXlf74r1NetJ35uZcPQMojcH447edAgYrWyYDNC8Ol
	UVXLA1PMWeX67F8iuhNUwNZBy8DtpPHoe9Ke3yaYzDeGOqT1du82BOUCzcgokQi+nUV3wIw9sbK
	gU4p1BJyYyNzgBib2x66Tf2jnq3MnJTL/S3qLAY6dGvKOAux/md13gHqz2uQeHiTUcoKxIggbUT
	kHb4M/2uZLfP+Yvdcr0DpOiIjv5b23yMDIZLNUVkP/Ar9qEv19V7N6kwKH86Au0+Ru+teFl7AQf
	kjj2N2iQ9clyNi1RrNQ065e4UYqs7bHli++I42rtmv4z+ocBGPoet+djRZeBstJbJFbZqIIlOBh
	Smw1FXo9Pv5NZAIPmYVtH3SA4bzg6PocFOVBGXYrz9RC81gAPMqXUQXXq2JQy1Ggcu4YZguRXPw
	PkCfMlWCavELyB2p0AqK3o3caZCXHaXmFsJ992sn/e1QlRlj8Ybu/8kKsuR7aqxZ2sNtnCjDY1z
	tid/bQwvtz9Wkzp5sHxc62K0N17t+LEE6h5pBzzo0+Ay9nwWN/Gd/E2xXtiCQLGsz4wuPXO7nkG
	aLCg0f7YSmaRY37ROOb6mlWDAITihzWWxuvsD9sxXepDpxTqXscpTNvOK5Y0lyvhwyOHweN3zFT
	45GPTGUlocBerrqo=
X-Received: by 2002:a17:90b:3950:b0:3b0:92b2:2e74 with SMTP id 98e67ed59e1d1-3b0db6f6c35mr1062138a91.62.1793934228109;
        Thu, 05 Nov 2026 19:03:48 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a04a39sm118179a12.15.2026.11.05.19.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:03:46 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 06 Nov 2026 11:08:04 +0800
Subject: [PATCH 3/3] ARM: dts: aspeed: ventura2: Name the USB-UART bridge
 reset GPIOs
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
Message-Id: <20261106-ventura2-dts-update-v1-3-b085ece9bf57@gmail.com>
References: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
In-Reply-To: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=JErXBRcaQqttTRbJYkhlXXvroT4ugDdSkuI4a3TfxsQ=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq7USWOSM+Se8JtxUUwtmuKQLlZfQThISypYBKs
 cRvRTZN/aiJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCau1ElgAKCRClg0K3CVbE
 gTnNB/9gX6LuenOCksACETKUVDRyzmW1xPaQiXCUzc3TTNnKY5mK80xYSM49pNtveFr/8gL9L1A
 4ZTufnTHOb/E1VsKBVmkHFP3tWQSskkBAlnMrvXeOd3N+edRLpX63+IKV+eKhChv6SxYyZmc+u3
 zEi27kslPErTUrWnjUKy2O8vpSLYLBLw3NOHCo/nweTGmxqnMat8zZwPczvXM9kS/b9HROaXEiN
 p9E6HlSi8G3q/mdZreGKcID0wHtwd/VagH7BxR4E+tLjYnpX2VVGiblyJa9VgBSu8RnDRyJPyVz
 3t+HZ4TLKxdxa2ruyituo3pcO5ZAB3zSAPQ/hO//B75hvGtd
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Lines 2-4 of the PCA9555 at address 0x20 on I2C bus 6 drive the reset
of the three USB-to-UART bridges. Name them RST_FT4232_{1,2,3}_BMC_N_R
after the schematic nets so userspace can reset the bridges.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
index a9c5990ef969..af26256f19f4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
@@ -1937,8 +1937,8 @@ gpio@20 {
 
 		gpio-line-names =
 			"", "",
-			"", "",
-			"", "PRSNT_FANBP_0_PWR_N",
+			"RST_FT4232_1_BMC_N_R", "RST_FT4232_2_BMC_N_R",
+			"RST_FT4232_3_BMC_N_R", "PRSNT_FANBP_0_PWR_N",
 			"PRSNT_FANBP_0_SIG_N", "PRSNT_POE_PWR_N",
 			"PRSNT_POE_SIG_N", "",
 			"PWRGD_P3V3_ISO_POE_BMC_R", "",

-- 
2.34.1


