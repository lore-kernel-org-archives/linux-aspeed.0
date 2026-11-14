Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B615606A330
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Nov 2026 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=I26gAAPd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRfqq69dJz3bVW;
	Sun, 15 Nov 2026 03:35:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794674119;
	cv=none; b=YcLuE9cHG24SVYyVmWLk0/h9wPEiL74eruaJsdF86jfmZct5sbNg2u/MTyH3/gcafOeUWThuhK+yMGYsSNXUZGPtu7abV9Xem0mm3VVNLJyzdcYzxWiQEON+O9pmnNzSprX5y0dYBnFae3suQMuFLk/nA7i1V5uzWaUAirGQcwEam0zIdC2iYPxgBFhq5xsBzLgQGgkBQblOoNbg9k2bRAw5IVx2xtc5xcsZvoMvmyYmlSq8B62QFvJGku48Y1ZkgzehSH2jmMeYx3ItaMJ58sq1isx2VRf2ZCzZa6GvyXt3k3XHIdsPfEidG4+LYMl/edlgIom4ZjLiVpJ49HbU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794674119; c=relaxed/relaxed;
	bh=AcPZdHRdSNsPahoZF47dsbH78l7FWuZxfz//QqM7BiE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Y9jfjz0DHWxENwcjBQVsatEsZ4iuT7Z4IgQVfE4r8Yfj6GIP4L1hKZUqCmF6J2FaMHcRoYHe83D0NhWns4C96PFvuPYH+2UEkeZzF9jtcN9c/XzirpyW0mLxLfOnH9e4sFJTr6X0dL53JDjBDTmOgW9r0Gycl5bKPGCizp+hyiKnqqpE3+sYRGIP8ITJn75aM9KCG4YBTDWFzfRpgVwMEF05DH0owsuFjeXi2K86KHGuCbUGduqEMW/KYvDN6OxCKStSG99qocylec39/su/rZxSPxA7xSlG3ayLbimKyZgvHk4QJIOZAo5LnppEMi6gmIs7tFjcXfb1mL+rOjR3yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=I26gAAPd; dkim-atps=neutral; spf=pass (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=I26gAAPd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 341 seconds by postgrey-1.37 at boromir; Sun, 15 Nov 2026 03:35:16 AEDT
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRfqm4Lyqz30hq
	for <linux-aspeed@lists.ozlabs.org>; Sun, 15 Nov 2026 03:35:15 +1100 (AEDT)
DKIM2-Signature:  i=1; m=1; t=1794674111;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnPg==;
 d=web.de;
 s=s29768273:rsa-sha256:lATMqEprF5Lf9FEvkJH33E/FaWby
   YCkccvYGnC1MPTl5sjh4iWlfYTsoqKIeh+47wNFj6uT9oJuNvlc3yICE7SQgKB+EuYdZVKRo9AC
   36bINizJACwbKfsr2kbU5K/YcupQi2hf9+BqHIaRr9smOLV81Z6vk27wyqzOtbBsDm0bh2oMStH
   Q0ipOj77xnzvyBg26Xw3GLnFKg6hbmkiAAJ1CEc2C3ee1bRhrhcLhxIiVDw0C6X6h9O40pETPwx
   uzQYkolgBqxvthqov+RpMhrVb85dM812gViEiM2RD4jViEAr9Pbh2yTDo3cpdScx3dPkZaVrry9
   RTgAaxltIZQ1XQ==;
Message-Instance:  m=1;
 h=sha256:
   BlStuCcUESvgkKmi+yen6ZihMjXZlsyyBTbKPX2uw7U=:
   PDy4DKtgXQr5TwZ4DuYRHtSIuKhXnqHzeanv1sSzNBc=,
  sha512:
   5CXHpCV4cPWSIyg2E7wQRdRKHphy8f5eyGroQ6Vn3F53lKg1W8OAsgdTAakVaGsXDocmcKH9x3S2ruu78xfN+g==:
   x4vAremxFZ9qbjCjk0gISaOW+iyt5r9vFTdeGjVlfoqTPzYa85LQuC2UMUnSoFJ953Vdb3J/QnnTBxv2FlarZQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794674111; x=1795278911; i=markus.elfring@web.de;
	bh=AcPZdHRdSNsPahoZF47dsbH78l7FWuZxfz//QqM7BiE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I26gAAPd/GN7VeKFB7/k4NozXY9pep76hLUwWlAqy/xHc6nq/o4fycNOliDM8lfp
	 +inHWmKBLMNs4SYTOoGHdFZgdGrMU9kWa782WQNSyM17OEdqMuRpO/9dhRZhEczpH
	 GWUBYnQeV7Obm/9qAKIM+F+k0qFuDIyQgVMukezrsMVnHGftR05mL/CGj4np87YSw
	 e+70fK/X6W2gTArCcg3vlQVrcayeuEiv61OE49X3J94hJtS5BdqNfF7HOUAqNHZAo
	 WxmAdYcye4w/1ZvEKlGmmB0dFGCscqlaP76P+DL+xzSZlQzyNAcYtGINGGXp+L2GI
	 thO/TyPjILucy7PELw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1wua1X0ab0-00aMcG; Sat, 14
 Nov 2026 17:28:25 +0100
Message-ID: <bbbc7228-cf98-437d-b240-ad29ee7fb4ac@web.de>
Date: Sat, 14 Nov 2026 17:28:19 +0100
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
User-Agent: Mozilla Thunderbird
To: linux-aspeed@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Billy Tsai <billy_tsai@aspeedtech.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Philipp Zabel <p.zabel@pengutronix.de>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Tan Siewert <tan.siewert@9elements.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Felix Gu <ustc.gu@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] hwmon: (aspeed-g6-pwm-tach) Use
 devm_reset_control_get_exclusive_deasserted() in aspeed_pwm_tach_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1pT97BuWi454FNKaCo2ZE4Bc56WgZ5gBMlF9gSjUzfe+zn4fDt/
 e2A7Xxvn5powU/en6gXeySeZEG2NmB/g42UDu6jUE+nVYsLteujMe5ET5ETNJkp/BVu9ZD/
 Vb9etjAtlILvUP/cD70xF+ZnU/a0NQYUXwHv8+kJJ6RQbZixWqKZriVLDhNZYyg42elOiiy
 BmpyAO3RXbYTSEYgnZkIQ==
UI-OutboundReport: notjunk:1;M01:P0:bWASZDX2mys=;p2Ph5U1CttpPc5Sk6cEdPkWaCmz
 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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Nov 2026 17:11:34 +0100

Use devm_reset_control_get_exclusive_deasserted() to replace the
explicit reset acquisition, deassertion, and cleanup action registered
with devm_add_action_or_reset().
Simplify reset handling and remove the custom reset assertion callback
while preserving reset assertion during cleanup.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hwmon/aspeed-g6-pwm-tach.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-=
pwm-tach.c
index f07c9a036b69..a26a0d48dde7 100644
=2D-- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -448,13 +448,6 @@ static int aspeed_create_fan_monitor(struct device *d=
ev,
 	return 0;
 }
=20
-static void aspeed_pwm_tach_reset_assert(void *data)
-{
-	struct reset_control *rst =3D data;
-
-	reset_control_assert(rst);
-}
-
 static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev, *hwmon;
@@ -475,19 +468,10 @@ static int aspeed_pwm_tach_probe(struct platform_dev=
ice *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "Couldn't get clock\n");
 	priv->clk_rate =3D clk_get_rate(priv->clk);
-	priv->reset =3D devm_reset_control_get_exclusive(dev, NULL);
+	priv->reset =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(priv->reset))
 		return dev_err_probe(dev, PTR_ERR(priv->reset),
-				     "Couldn't get reset control\n");
-
-	ret =3D reset_control_deassert(priv->reset);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Couldn't deassert reset control\n");
-	ret =3D devm_add_action_or_reset(dev, aspeed_pwm_tach_reset_assert,
-				       priv->reset);
-	if (ret)
-		return ret;
+				     "failed to get and deassert reset\n");
=20
 	chip =3D devm_pwmchip_alloc(dev, PWM_ASPEED_NR_PWMS, 0);
 	if (IS_ERR(chip))
=2D-=20
2.56.0


