Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7F606A31B
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ry3JvG/H
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLPC15mJTz2xHG;
	Fri, 06 Nov 2026 14:03:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793934221;
	cv=none; b=Svmyi+BWWVsqtU0zY88tIehXbl/TXlArErp6gRNoxuSrwFZSUf4cfKeDnSLUqGk3P+1rydzBA/2w0+MwENvPbkpShiPxyDJY6sUjrYbC9y7uyv3cEh761lF9Sta1Qdmb70yGF44qoyHSczQYj9Cu00TgfN96V2ZZ0MmbwkfRWk0mFm+WR9pd1fzzgHUfBkKfnt/l7A/4Z1JVlyBr+YoL2Ci601If3fKWODzCkwKFZd+XavvNo+KuDgzDc/w4dVs8ym2RqImWiN5A6TT/0uwKGM2c6IoE7qE0yGwvF3BxO0IQiF/CQUTaUgkO5f9oFRCDgmAAJ1mJ35vnh5kFrViaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793934221; c=relaxed/relaxed;
	bh=cL6Lm2cBZjv9q+hFge8UMv8VlPsyusharMMb4O8VvGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNroFwakjLPLkMPIKnGI40UEAnLWbTJIWiIxkieeuSepuPmv0xqmV3f5/JUA0z6YtX/zSRGogwz4KuYzVnHZH4crEktIsWKJRhonrrR812m0LcqRiocr/pIi/GKSDB/BlWY9o/quq39N0Hzi6Emxdv/nCq/OZTWyH/BxPQh5bhX6qldm6Y/nZYK7VMCur7FIHafShiaKy+fVb1VhcTw8QUeSNTPu6GmdKSH4OtlR0EG/8pokmlCiz/KeUJ5RKccQfK8enhqALUceFCbBr1dP+4bM0yUVaRjwq9Si9BVlDBOcEQIdoDiGUlMI1uFkw5JmxWJdaHFwnUDzAOPvax5VIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ry3JvG/H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ry3JvG/H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLPC11gJGz2xGr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 14:03:41 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso65499a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 19:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934219; x=1794539019; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cL6Lm2cBZjv9q+hFge8UMv8VlPsyusharMMb4O8VvGE=;
        b=ry3JvG/HFtCGHAoo6oHWnbml1ZT/ztueH+Ef0yplZtt3/ClVEFZ6UrBOVinsvwibod
         rJ5kp3hEMLBFQH5jBb0XoZy44Rpx4sQy8OU9AqhoQ7cCq+kZDCZLSxjJk8FRYBC3ZYdt
         EpzvuhdvQ/9qsQ5WRqVFU2uYEpuj8iA8LikGxfXTQovqBVZkkNoBTcoSOoI9t4NU+XWz
         dEZjWpFo4KnfJwAqAxTXv1EGOcp6Bu+j4cL+72Y/qYMp51Jo4xcKrZhsMn7xkt6LFk/g
         Is9vsJ+bie70t6A2L1jTiPjrFyQDdaiu3lsC+h0V82Mbc1Zo+Q+XPDhqwQE03iZ4P16i
         6qvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934219; x=1794539019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cL6Lm2cBZjv9q+hFge8UMv8VlPsyusharMMb4O8VvGE=;
        b=q8wseyR5nxpu3mIBiG0uTcXKvRVKdVwkcYC8dWSOtAIR/5vxqs6Z9UzjidUcg1r4Im
         FElSDbY6csf/pPHwItvLT8Oe4UJ9D7WsGcITJ0GinpkHr0UxvhAM5XO95ie3SwwQZnXB
         nUCKqCFF0AfD+UlvxTyAQnkvcxfCAkdn1UBd9eDn4WX2b2QIg1KtMZw/7j+sZqv2jV+f
         BjeCAS75dttzrm32QTby9/tl7V9jKuu3iMR2FlwMcBkAvkRGeNz9UsLP2E/xKYLHSqKT
         hcY98dBJeMgoZ65M/Wp7lRvAzgdBw9E6wvKi/Nm8E/zC4y6saIfSkgt0QXeFWb+PU/yO
         mz6g==
X-Forwarded-Encrypted: i=1; AKwUvBy9cgXRNFrbfNzo+quae6zDG0Wa/djtHFL8jTzZYLVzVAu6YnCfavC2/8qXwu7xVBkOgTRvB07pEUm/mAU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9hcKdngmUn6ykuoNWKaiPY96PhXP8IOjSkkcgDMjuGf3DYzJo7
	egLJYVxpyqrzPrBbzF0xBv1S6VGxOR2PIuvibfx+RXJ6O66Ls4++jMA6
X-Gm-Gg: AYBFou2+OeDdIezbdlzOGLT03shisi1BTTzitL4y9XDLA939DoNFZoVefhW+NdLRS6i
	97qXmKxiWvjj6Cez+Xr3w2sKTqQizTkjC9YXnhiZaX+XW7UCs9kwJSPFg5wNQy3YqUUA9H5G/CI
	Lf4lCRA8fNnSMWYahwC2iFcEG9OSknFmmvSxtlAtD+XiMnej383S0FDYt7T+/AO6p3A90CzhQLw
	FlnquAImLUd5ef59/Sb0SceJBMxZy3zO9kd0PZTvDjYznucT2mBtCyTllMr5PUyUl1R3spRCHob
	iD/pHgRw43MTIG2312mzJxQHTwFHP9r0tVGwoCHDDqyDI5TUlroHWzSAxNvLphgWTHDue/uxTto
	048QoXRB0hXdUEg3MsqFwpwUkIDEsBPLIelBkllvqBOifIrAwV0yb41//6terTgJhbvoXj34ISf
	5GiTZacdY8LfiQCJLWlQ5Tzosp8v7sgSuiA++445Wi0TRu0AYlGrssi7i7yFxy/cokrnjd4q22g
	oyy3nnEA4SJqHxZp/4QnNE8r7Cy1ML483rsy+0sZXVmFOm75l9jM7M2P0VbyVtkVw9DcaNxK1GG
	TjhhEpnD4ZjvWD9P2l6NMeCNn0lcg5zaNnW1T2yAxuskNeI4bQ8vQOHYBpt4OOf48IlE
X-Received: by 2002:a05:6300:67c7:b0:3e2:3222:2559 with SMTP id adf61e73a8af0-3ebb2a978f5mr1627729637.62.1793934219096;
        Thu, 05 Nov 2026 19:03:39 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a04a39sm118179a12.15.2026.11.05.19.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:03:37 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 06 Nov 2026 11:08:02 +0800
Subject: [PATCH 1/3] ARM: dts: aspeed: ventura2: Add LTC2305 ADCs
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
Message-Id: <20261106-ventura2-dts-update-v1-1-b085ece9bf57@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=s3+YaNI0kXS1WHGDFc6jVaitSFXgSkUDG8m8Ajnq+tw=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq7USVrNYo936MKfY8QZ8ByY59Ccq89oZ8md29i
 fRH6E9D4z+JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCau1ElQAKCRClg0K3CVbE
 gQTMCACAEQvBIE/8WEFrZZ9u96QoYyPrhnfijSAw8ZPvSKASOXgKbhwNEy6a1B/bZCP2Qq7fbB/
 rwWGG3+VsplhWYGMjCzV/5hJHtPbkUjMNw6RqLytydlwFNlM4/MMJ5BloWHIrmm9Q2gVI8onIvU
 E/rkDcrss9iLgt5cFCwV0IJdPZPIic6Nb5OgGMoqmQ21pRTiu6GxOY49zMJOihDbgtd9vVGv6Ex
 /hkkon9DJfi7gKUgU4xHoo7nyDDP5c3jM2FfB6oMP/hm+vs2LuExbc7VtXj+QKd+M7BTBqPoiR4
 tZ1dplLGWvitZI8JDLtX0gtr1PpREtIggD79yh5gb+MsgISe
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ventura2 has three LTC2305 2-channel 12-bit ADCs: one behind channel 2
of the PCA9548 mux on I2C bus 0, and two on I2C bus 3 at addresses
0x08 and 0x09. The bus 3 ADCs read the valve voltages.

Describe the ADCs and expose the bus 3 channels through iio-hwmon so
the voltages are reported as hwmon sensors.

The ADCs use their internal 4.096V reference, so no vref-supply is
described.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts     | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
index f3dbdece3076..50e652cc37a1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
@@ -190,7 +190,8 @@ iio-hwmon {
 		io-channels =
 			<&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-			<&adc1 2>;
+			<&adc1 2>,
+			<&adc_op_fb1 0>, <&adc_op_fb1 1>, <&adc_op_fb2 0>;
 	};
 
 	leds {
@@ -392,6 +393,12 @@ i2c0mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			adc@8 {
+				compatible = "lltc,ltc2305";
+				reg = <0x08>;
+				#io-channel-cells = <1>;
+			};
 		};
 
 		i2c0mux0ch3: i2c@3 {
@@ -583,6 +590,18 @@ &i2c3 {
 
 	status = "okay";
 
+	adc_op_fb1: adc@8 {
+		compatible = "lltc,ltc2305";
+		reg = <0x08>;
+		#io-channel-cells = <1>;
+	};
+
+	adc_op_fb2: adc@9 {
+		compatible = "lltc,ltc2305";
+		reg = <0x09>;
+		#io-channel-cells = <1>;
+	};
+
 	dac@c {
 		compatible = "adi,ad5612";
 		reg = <0x0c>;

-- 
2.34.1


