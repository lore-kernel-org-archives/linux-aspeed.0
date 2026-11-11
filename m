Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34860A2610
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xi7ah+pa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPY6c3tyqz2y2h;
	Wed, 11 Nov 2026 17:10:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794377448;
	cv=none; b=IjPRoe7kc4hWBLvVE6Fgo3J7DOw0CIg9dktVVXcIZt0lOznm5EZEJTnLick5jNuis+UQongrNsZC4FxE9iSEJrWGdWbAq7+1yBN+X9u+e1l+PHilaPO1PorVEcuD3fy/vq6DTJhDixYPjlvjFMajpgdO32CTF3/7qk9HPNj/N3wWZYKa1uCBr+spfhNSq7bNqpgD/I+Up84R87aLdLs/41YddNKIQkKFzjJIWGpJJJPWWLhaWS5QzVg5mHYqhNBmSF6l5a6RSLR/rvNyu+CCwwmLGBFAPOq5JPtjQLR9FH/O9ayHGjgTjGYE1Y2vkux3oqQDJpEDqAy3N7AQZVnQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794377448; c=relaxed/relaxed;
	bh=cL6Lm2cBZjv9q+hFge8UMv8VlPsyusharMMb4O8VvGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXITXJuaGwp37pgU2rLOHbozqvB1rnp18iAyBU4bLhWXLelSwUoeQzOjujpYU1C/4h3346C2SRm3jYyy/fce7zbXLq31P9RfQHlaVxr6rIgIZfUuZKxZOBYvDuFv/z9O0JFeEJCBj7VQt/x+3w2gwSmQjLQHjLELtDJ+Yht3MyLEBZU1CDvj+pMgYCADFqVjAPZkpOhx6KO37asqrNEBnVGZ/CpYCPdvJvc+rHCBsUi8ENgo3QkuQlLr+esC7qUilbfY/ppwZnXvZ6YhtvKeM/zanPCys2SBd6wIpsPYBnCyton/QOYD70ws0O/3Dbjbe1Ik4Q4Ie6Zk1lpRQIdlAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xi7ah+pa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xi7ah+pa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPY6b4Jy4z2xWR
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 17:10:47 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1313896a12.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 22:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794377445; x=1794982245; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cL6Lm2cBZjv9q+hFge8UMv8VlPsyusharMMb4O8VvGE=;
        b=xi7ah+paMvkZpnOIjYf1jet775RazEWu5cz+weAzGdawcSV44XpRV10d5TtRFVCJbz
         55EIqu5MWq6CybVz7pqiO28YamOITMu14ZXGMIDHO1RShM20iZF0HH3SNI4Y2l2hSgUN
         xU35LRqwH0zJYc92k1He1bSfqf6ym0gAyBnv4+K85iodOB6JXx+KwsCIyfEi31b0adcJ
         UKAQVGJktXyaXjf9mkXIy/qGCl0qT0CCRp8mWjyjPRbukZfLfxCrMJ+7Ch4/pJtzbtPY
         xpibY8FX4SIk6uXlNhOT+WIWrOGh/o/WXCA71xCFIoJ+lv88FDz5HNjncLXqBlnT9cce
         JICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377445; x=1794982245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cL6Lm2cBZjv9q+hFge8UMv8VlPsyusharMMb4O8VvGE=;
        b=eIzd440PP+rls/f8uQOnyjgVSsTG8P/nw5vKUCkRZZ0vi0uGK61u6Ot1eoiOv8luWF
         odNIjoATcyvVpl9XpInSkwt7wylskOyvOccJ0t+rARO/VYtsJEWZSmHjhFhRqE6viGH1
         rKDdffawgqofEcEvyQ5bffmdz/a4lt2zBd9MtYBp2EhWaXfJwBDatC3Rh20tXL/4u18m
         3jnsI+8BboJhdvepNK0WIsulsVrGPVatCsWAFknaHW46tOPQYbn7bk7J8ppHlKCAto+r
         TpiFg0TiiRnoqJsFRm1vf8c95yLhtDI3C/DEcuGHmhxlIaefHTG4ts/j7Za24HXq1zBl
         KUwg==
X-Forwarded-Encrypted: i=1; AL+hErElm5iAwI8bXbQAcPIjfIo+q1n9QU05dMFz4S36SSx8S4jaDo8Z8XztlUhyzLHvMZcS8IhNyhUUW44UwOw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8a9DbgYg98LMJwEJfhlzp7lpGXnV/z2+oZFgrJ3l9U/SspsR5u
	6oMDQGGSAKhqs9gBgWBulUeCOL+mz+ImO/rcn06Acnfhuw9jL/TpwIKp
X-Gm-Gg: AYBFou0FN7Jc41MSMJ2ehTNvYMBhAXCiHwD3ocfUSucKNmH3YaRMeFk4yJkJYQYtEUr
	lVsgasJERS/6JSFPFVyvV9bJO83z2kPlY0C/WfKX9/qAdFPZKNy44i03ctybIWZmEVsD+85u2vh
	db3fob3l0dgW2I2IoGf6dIT+dtlxPybdkVp+vIgeBCKlCQU08OlfaS0G+edTSvhnqKSg/5bJT/X
	Sjb/dd8fqHp1tdchhePZFB8oNOFIp+To71tUpE7wR8x7WxQ5ADyPAz66vOrJNNkG4PmYo0JtbAh
	gR9mPiu5Y/HoSdSNmdAodoJEyLYnHdNSlkYX8N6pfaE5WWUjyAG1/yMOik/kDT4Rgkq/CV1zBs6
	8IDCNIOqRrP6+pgzg9yJMzsh3WkA8iaGSdr/F13c6kn5UFBfjUnbcxM/Pekhq2dB7Dk8HoHrCGs
	izYbdcUBYzzbRdywDJ48Nj/fOoSHr9Cj3bS+KMAYgo127FgLk3CGS71de2DfbdLA11Hmkg/ls/l
	Qw4TCbuhdRgah+CINHyKMb3YKa5xXnLvz0Q1xVQKTr8CsXhT7gwKXUhy8eQtqleL3k8yETAJ8yY
	4/a9c6APxqHIYKzD4FEHX821hytS9w8KHAjIQ2w5X1ayu8zqqUgWKdVBYEsFg3bdyWGK
X-Received: by 2002:a17:90b:4c86:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3b182eec306mr1365020a91.18.1794377445217;
        Tue, 10 Nov 2026 22:10:45 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db7e8b1sm2978557a91.12.2026.11.10.22.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:10:44 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 11 Nov 2026 14:14:42 +0800
Subject: [PATCH v2 1/5] ARM: dts: aspeed: ventura2: Add LTC2305 ADCs
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
Message-Id: <20261111-ventura2-dts-update-v2-1-bce5b5dafc1f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=s3+YaNI0kXS1WHGDFc6jVaitSFXgSkUDG8m8Ajnq+tw=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq9Af0ExsDKf8CzltHQES6RXvy0dPDeU8+5oV26
 lfnR1gJmmmJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCavQH9AAKCRClg0K3CVbE
 gX0hB/9kK2OVIxktjiccv5Qt+4sOvnD+74ZO2VgbmyXsfBFOqFRZnegmkamGZX8PQLnnR2zXCt7
 9legz4pUNFwgTdQAbuzSYYU3ACZhEfDbRixgiSPS7789/S8NXF9D4zsBTCi0bdTidgZ2hpYxdmk
 PJNAxo8ln23bwohai178LtE6cpDKMpZhQ+rCLsmEFwultsfybdutBrZyTx/h4WWRqrw9Fxbzyf2
 IBzozq+mFgPINyD7bU7gQ4dIecIDT+jmWP6Vc954uAhiD6H4dCuBAPyMwcaSaA+oKFepdVvty4k
 TwpozOspNnjpkbU8EMfhdjnlJ6ySp3iowSD1WSUKc1rEfCGj
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


