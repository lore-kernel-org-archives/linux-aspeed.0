Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27560A2637
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1CkEN0C
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPY6n1ZYdz2yKn;
	Wed, 11 Nov 2026 17:10:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794377457;
	cv=none; b=YF136jBrqnXBlTFlTwA/0457GIa6H+LQclwftVrW8zeG25TX89iHfZ0DiC547mgZglEpOIKQD8XEGFvIJayCw1OgTaoNjxyVQw70NVobkn0i6DcsY+OWfmvAxnuQnXARFauVLQnNJu93Qf0nl9CIBGdXXq6fwejWlLKqn15hAz9hNI/ObXwrbBGQG8t/oHZg5s0L1iCK8N9hZIG9DRAbbm2lNsbH4CyvvcM2ZKgs9n59/SNv5M5czh1PPhpnltTMkpI+FenSBL9WP9xgG8F7SKvsP2DUf345mjAJex3laZdXTsHNh4NX9wi7OHyZ49fl3z+Elmb8p1RHjNhiL7vS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794377457; c=relaxed/relaxed;
	bh=adTF7M2gMHj7eJOUoZHUfGntqMgezvSTHYPTjsdEjag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Apq9z+vfgOwmMnuW6veWdNwh2pxUBSkLQ0feH6vfeRjv23wT4aNmSq5NWN+hj+Ip98MqmBZyR2TLE+Kb5wM0208vwD7H8dS7+GzTaCwQv+3Fu3iQpT/Pv9LH2RZuNWG8qpCP0qtdbNnLy6ACRUJ7YGGV5XYcwdg4dHQewJKcDaplemu+COjxvsdEDxgMQ9Q4VmopezaokGlacWJyiayvfV9Q+AwCK+8tV4O/S6WR+jHSOK8iqtMiv4TwSSu9HsHfn5GcPqGghw5wPDvpv/YkWRziIrHNaP0/O1Zg4U8ZgvDbfbZXsbhR7sDPzLVZvoiKt9EQkB4tLZuGtOrLIiYjUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1CkEN0C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1CkEN0C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPY6m4cSBz2xGg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 17:10:56 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1674992a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 22:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794377454; x=1794982254; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adTF7M2gMHj7eJOUoZHUfGntqMgezvSTHYPTjsdEjag=;
        b=Y1CkEN0CqGWbLkWQi1tM1bjnrld3dphozGr48s79+d7TMrGKG28Bb18L30AfLI1gvs
         iYVFUm2UIsAEHpOApYRgep6GtWf6QqlVVYWGlelaUTdw1LARAc4w93gvtYa2HdicE/dI
         y2VHBqi6dKGBB2Dq5vFjcSeOcMunZCg+4UNWr81xmJkssE94EtdQhDBcD6o5OtjjATgE
         KNnjfCI1lmTr9jgM3LlyWxQY9lONoVIcOwAiFBLtOzWO3W63GbiXUN1abNLZcJXJq+cM
         FwKPafTkQ3Gasmmh2muPI1f3qyFMCW0/vO2hjDVfQ18PgK7CCVJWhmC4BpFb1RzBsesW
         YRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377454; x=1794982254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adTF7M2gMHj7eJOUoZHUfGntqMgezvSTHYPTjsdEjag=;
        b=Moge42QRqpM3dgXd0rurhfqMUWu32t6pC9H/rEXV2VQTvczatpkPos5dl+wUXq/dri
         ZmKqisGZq0LzMPMT3z0ueTR0t/KEkjNg8P0JxFlzZ5iuXnY8+CXAffJZN/Nc1xzoHL3F
         wrUOJzxZ1nzAnbdtGlvD8qbAUg2X8YbdXnQqucOVj/YT+skUTYXiZgwvX7/M6na2Er3z
         soSmPCwQO1AxoITyT2hD2dAyXJEPhagDY0pKqOYGIoFaBZ9H+G5cKuV+pmjrMKfnw8JS
         JdYLMH1HP8jWJJJjgnwTfl5yB+WP8LwwFkfPIuYow8AAvIXc/1Vik58GaVF6+n3XWNXf
         Blqg==
X-Forwarded-Encrypted: i=1; AL+hErFmUVETlmRcD9K9bryN4gqzOIqn7RaKKNFeBnmyKakoQyE/wfz/5tAVl8pi9j2nW0izUUyoRwbmtkmSXTk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+CB+nhgatTm7EsFYWJ6usK5h102OseioqZx0vk4kJ3gzi7bUbO
	VL82xhNDEkqaQfbySfdZGLahKcSgn+9+1ovNZGELJOQnQvu/zjFPdtyg
X-Gm-Gg: AYBFou0Yto5QlTCjoMjkPL6J3eXX8G6lYMQjjYoIkFwvmVIfOXcenjIhoANHmQvb7jH
	uXpbz6cxcgHOpF9OL5ghmyuD1sjzsOHvFCfTJrnsdltSzBWJ0y2R/IQM1LmKeWVl6+CH+/W3OiA
	VROjJ0jBq7Jdx4hzJoPvMaztkMJgTTtTGaAUkP1YjcQJJAqWYyKDj+MFI2RkbTM+sW6dlglho93
	21TTcMa20hys5csysO2VGGQcQwFEvJQ2qiSk63kgCpmZRK6T3d1dgNfBNKjlhVyN90W8HFwlEOV
	7ZfmrULdvM1M2uktkyksrp4+1D6HAdu6V0TBQfRIu7p42HaFsTdY92N13y6LsLgQOLa4Mam5+Ih
	r62cuE60JsMR9UEulGLK+hby6F7G0XhUVUHVwlwqVawiJ3PDLDWkwmrdN3gUkPAzYenNIeGcuIh
	VQC5ivmpMcl/NxN/bPBCAOzJ4kWXija9FkhtGMuqXio1JVyONgTMUSGlY6W7NhHNNZMYt8sqq3c
	KCUL2exhj3cnnK+8fUKfrE20RSXS8y1irGVnNe1fiaUbeevfWgRA1MhDTLMIIgqTDfr3Xi0vTv7
	QjRzG/4P/1p7e7bzrW/D2xK/Flu15SY188xX41Gdr1S6Q8c/LP3OlgNOupoezC+UBH1p
X-Received: by 2002:a17:90b:5910:b0:3ac:9d26:5532 with SMTP id 98e67ed59e1d1-3b182e12787mr1641552a91.3.1794377454347;
        Tue, 10 Nov 2026 22:10:54 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db7e8b1sm2978557a91.12.2026.11.10.22.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:10:53 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 11 Nov 2026 14:14:45 +0800
Subject: [PATCH v2 4/5] ARM: dts: aspeed: ventura2: Name the USB-UART
 bridge reset GPIOs
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
Message-Id: <20261111-ventura2-dts-update-v2-4-bce5b5dafc1f@gmail.com>
References: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
In-Reply-To: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
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
 bh=uxlzFpBewTlOUpIvaHC+sQHRHy1iC/2nchos0sKDaSA=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq9Af1Y75M000yKvj+EmMiYb+D2UqM+Gjo5QTY+
 aYZCRbqbnKJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCavQH9QAKCRClg0K3CVbE
 gVrfCACO+o3U98bHLfj9ft+SUDV7IbCt3mftqCSoznSCfIaMiRMu1dIttWlQN2p/TX6BzUrsEcK
 ax4g91upkLZ/tHwX0pDAHawfcgNbviAQsmglRgvCNxhlk5ZvzQgAYqrDAzZkj/oxX4hx8yrPimE
 UJTsTTFHDLqBAVOGQ5pcPvnnW/j7NM+lOctLzK6kdFPWb7fedDRM10xaj9es9NJLMrx5LNONiD8
 TRq/DBbh4x2C5EOhPo9nfdKuvOsl1JqZo4i7J84arpRwXTVzAMGjlyQgpr6vr5mqd0RPCSd8CaL
 8xUw8eJFejqLyk0H2J2K0Hd4AtvI/XZknibcG3HHZD9vUdNz
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
index c683ac19aba3..a5e6cc94b280 100644
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


