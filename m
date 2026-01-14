Return-Path: <linux-aspeed+bounces-3319-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB776D3CC82
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:24:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds0yp0WPGz3bt1;
	Thu, 15 Jan 2026 09:24:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404635;
	cv=none; b=jJQEZdSunHPprreIissp+JVsim+MwVJt48wDWMTq0ECPlEDPjF8ygUTUyYqeHomSem/t+9CWTjkdujOGXHvgShZVVPaOhB2/U4et/tSUtVBDuW6KY+vVIGQYVfYCdqOd/qAnXvyT6nbOQt+bqRkbf5lewq16x8G5ObBQ7dZx2/O8zzEiIkYD35hXf36JXBZqXii0LpJ/a/4B/IgSnEzIAvPNhXTVsDhXjJiX945LGjgjDJT+Rrj6by7dHOIjmUjHkKFTVYtd06A+mwYCAfUx1Itkb+aD3rdxpCSuLrL2sLEzLpLoOSzbqOIeu++4GUh6Y/K0MJGlJIJ3yW8UTyyfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404635; c=relaxed/relaxed;
	bh=LXncEA4jW+AgdDM8Dn/nTshgL+Kv2q2dFOJVpt182v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqx477gvoa5fpIjTKVi8C35GcXkSdIf4WS+ctiVEMOoYpN7BmCF03M5cv4InOfOBNpUDxstT9RAFkr78bKb6ZOKvckwzknION8vDSKVUUmrWn5kQMaMsa4k2cQhOB8wNvDk3Ff4A/pyxIoaTplrjCKpLwshCj1Ke6sopyTtxZFyXXWWGfm7PH9YUFduLXxopHXxB+fdL4GXOwK+vzOQXFdFw/rIsB0ORf8qf+fOO4Oq0dtknVA9wpuVbe9xxnfGsLSlE78nuTD2c1AIdAg25+Ih54hPjHo7obdzdGoOx2wcdawytyNW77DnHtoLUhA19h1dticUSMwwZBG6ChBBwHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L1bLn2gb; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUN24zd6; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L1bLn2gb;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUN24zd6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnQ4htqz2xYk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:34 +1100 (AEDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EChVWC3925427
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LXncEA4jW+AgdDM8Dn/nTshgL+Kv2q2dFOJVpt182v4=; b=L1bLn2gbhX1VQr5S
	DBrqZ854pXa6x0jHP6ADw0uJYdtEFgDvE4gD9u6gpzd62HMPmU14Zz2Yz+ffZGY8
	VY/nvssh6dZj5GnrLthMKJcVupO8HTQMojR7ZkiDkKR0XFxxqvBJUeKWNMxYJry8
	NwvqTbbKWLT75tdRH/42GO0jHIG6tsYxJZYxIt3+vwRt9jLFxqCKxsZvqH+nzhSP
	P37BGhyoY19MnsR0mwirGBB8vtCkN84A5wrbld369kXozOtYajjOcHWpNhrbOtSR
	u9dn/SmYXI+2ecIuTkyBKquonCEcC6bun8mA6WiUKZcz7VQzS0X7Qy1Zb+WncMs5
	/6FpjQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpbdbrh92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52fd47227so191421485a.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404632; x=1769009432; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXncEA4jW+AgdDM8Dn/nTshgL+Kv2q2dFOJVpt182v4=;
        b=gUN24zd6cCIVqnp/C83dRX5k2mah7xrT9kOAt0d6KDBei4xnyMPrOfP5OOpFNNOkiI
         NM6Fkh+PkTaEKuKYG8/v4EUQYDo0MuGSydfZusmRclbQRVJDmUjoz9JqYMMkWQfaBcjA
         wc2o1aJX2ePIUTaXiEXQHPrkNyLawbhekIhUmgMkDnGgVWFaT/qs+l0n9haWYSCOsFh2
         Iow/YT+cWzYOXiHUNvWBWyZ4kd30ZEJzdebxZ3sY0qcvGM9wDj6QBX2SbeN8jQxQnrIs
         YlvLkTSMOEWlx/HQvOMcC1vegwq2CPgEVoxy/5VcR658fyri1HL/Lgl8ylxsOjnHXTSd
         6oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404632; x=1769009432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LXncEA4jW+AgdDM8Dn/nTshgL+Kv2q2dFOJVpt182v4=;
        b=WSSEbD8KJEEJJ+hrG5ZmN1AdgtoSf3u+plQLtCMTvCZowtNv3eG6h9SOHNZdWHPWoo
         C6tXAybU59ojEk5DtiUUD5N2YnoX9NcP42QrzWFig6nbyKk992wl/pKkhXpzjVnq447J
         OSlrLFtuqeE72fLtgYuqZkSAqiInnkDIA2EFNQ3SsT6LkaAeMlEjSp3GbwPS2u5b/r9O
         +/J0fPcto6Zd/YbIg3py1I/+DrfuebKxBzobnNTA+wu6OXCMDztf1LnMHMw/EaoGX5oP
         Q0IOMI6S39wAED0tptvzILAFNfDYEumHUqsRk8wi922h6b9kfmbpNLfs+9gRLj6QBzuT
         lQXg==
X-Gm-Message-State: AOJu0YxdIB9S9dRIFqWYnNcgMSVGVzt7CuE7pAmB5qlezkts4LP4bqlK
	GZGYKe1HxdaIyfprIO6yZ65SCP1/0ZqNtDmoBOgG/BIhincTXravbs8tXK27lXD6khy9caeDMgx
	0m40ker/XhEWl6/QVxDMGLp2hqUlRpF9urYH3H+fI5ZpOZRqOrksj0m41X9OzyC4uSGLY
X-Gm-Gg: AY/fxX5Jj1H41C4Ez/wCCYVWwZNQGGT/zahVspcRkGCWw+oLf2oH/iu3EnbVhiFmjz1
	Zwb36gYAWNDC8JFfBeDfNKgf8Fj/UqAVDHEwA2KJzJejIlh2CLdj7cEg/UYCS4DNrzvI1X3z2Yu
	Knbq/uE+iBdZ0dkGvhZSsJ9NNie/NLiYbKRRmzdkDLP/w8sPkpCmtOO8XwmmhcL/GAzJN5azb/p
	0OY8mlMWeyuZidBU5ianEepNqnRzNrw9B9g/7UKEJ95j8ooOoiTaLb/ZNTddssKadG4cno3eTJp
	9hv/Dr/qel05uuooA6PY2t3ZX4xc48MWJ/8iZT6/Z9dcbvjGFP/JblpLrE7EUJfEN0wjwILDjE/
	wHhX+2pkIUioM7qK+xvmaX2fxephradJsPQ==
X-Received: by 2002:a05:620a:4804:b0:8c5:1fb5:1631 with SMTP id af79cd13be357-8c52fbcf18fmr431954185a.76.1768404630161;
        Wed, 14 Jan 2026 07:30:30 -0800 (PST)
X-Received: by 2002:a05:620a:4804:b0:8c5:1fb5:1631 with SMTP id af79cd13be357-8c52fbcf18fmr431947685a.76.1768404629608;
        Wed, 14 Jan 2026 07:30:29 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 16:30:06 +0100
Subject: [PATCH 05/11] pinctrl: aw9523: Simplify locking with guard()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-pinctrl-cleanup-guard-v1-5-a14572685cd3@oss.qualcomm.com>
References: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
In-Reply-To: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4481;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Y+FQmd4rABqYPyTPKLcnkK9CTadziXSgsQ+69hWhimA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7aELAglkIA71S9aDHg8tY0ki5ruKpcTIipIp
 9RdX4NrwWOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2hAAKCRDBN2bmhouD
 1/igD/9PwYlGol1XFHKqtfTdSYI+oQLSjl0z2sqJC/KrK4RW/0UQiErzillTKszLs1fzun100dI
 EhV3/cNFb7EkGAiUv0DOTJm2rLXXXAEKq4sfHj2AvOo4AOdm1Vhzaxohnqhz8lbieU5tgItO8kM
 CikX6JY0DNIPuK8tFa3jeDEczOXlluE7E41BjdvQjxbKKo8CAfks/3wwtIsxd1meu0Uh7pDT24v
 aYd+vgDxKOiXkiRG+CUevINMLknU969di7fKX4meZYuzU3R9984ZwT3wKVcWI1thioeP3d0iKIZ
 BLsydRVePUf0VtejFOq22/8mIaGexs7h91zpasohVsgWexuKGuKJNsUuVOnAKfAxsGZjauTVDrL
 18hpyd0FGakefMHY330a0Z2lqwnCW9k43rDquioM3Bdk17JEYl8zl6Ke/SDgqPsWJjHmhjt99ld
 hGunGrieUUrlWbMED9RW+3E0q0mHN8hMeN8k3fFjaBxIE0ScSmF/3Ln/vbtAuQF19W3wAWGZaJY
 GtZjFlirhF09jNZdVRAU8jaxTE4Y1Xh+h4BXysH0im9u+xRCGpdGx49RemYsLFWX5SsXtSUWzJE
 4DUYUyd6Czhj6ON/2GFFww6B8ToMmkk78qjK6kFM6DwCDfpPDItQEKm0PHRqNap0/QZwJwiIuvB
 W8opp7AXG42HEmA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=NvncssdJ c=1 sm=1 tr=0 ts=6967b698 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=sJPWbbE6un6nfY-uGV8A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: zWq2F4AQiKjO0JOnzipfgXAvrw8Tj8rO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMCBTYWx0ZWRfX8iN/E19F0CqL
 S9d9eM6X133PWncoKXeQmubc84ikacI8Vyj4PjsskEgE2ak9sdUlZKngXCKtwC1q/2UpAMz6xQn
 PulYSJAX+ZAlPqTPpfjJpHIt6kqdwAQ3bMm88nM8SxIu1SK3y3UWPDO8ZUZFvW9fixD1w5z3KJS
 Bwxec5HDoE9L3bf4JFA9D3TSS8sUT8IocKygs+LNdFK6E7ejS1CfJI/w1wQi+57g8t4PRQ7IU9v
 fvm99FTqmQjEcRgI8JvmesTNPpFv2IVpNN/JwRhNbkw47u3sC8joYQITzBDjilW2wlKFf7PlCg8
 LDRAVAnDaserix2iRl0nJ465phbgs3faa5FbzwbkWBI3/yqiUdUXhX5j/3RXXtAhtFhPqg6eCi6
 C23Vx3F9+DX6wielMhErhZhin1QlKrhvych9jJWXT6TYSzYS9bqgQqEsDK3zAtcdtdzinZ28l6G
 OT5eGgdIKkbDcRBd2ug==
X-Proofpoint-GUID: zWq2F4AQiKjO0JOnzipfgXAvrw8Tj8rO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140130

Simplify error handling (less gotos) over locks with guard() which also
removes possibility (at least by reading the code) of returning
uninitialized rc/ret value in aw9523_pconf_set() and
aw9523_gpio_get_multiple() functions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 53 +++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 479553a79216..02a24ac87ea4 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -291,14 +291,14 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	unsigned int mask, val;
 	int i, rc;
 
-	mutex_lock(&awi->i2c_lock);
+	guard(mutex)(&awi->i2c_lock);
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
 		rc = aw9523_pcfg_param_to_reg(param, pin, &reg);
 		if (rc)
-			goto end;
+			return rc;
 
 		switch (param) {
 		case PIN_CONFIG_LEVEL:
@@ -307,7 +307,7 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 						AW9523_REG_CONF_STATE(pin),
 						BIT(regbit), 0);
 			if (rc)
-				goto end;
+				return rc;
 
 			/* Then, fall through to config output level */
 			fallthrough;
@@ -323,10 +323,9 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 			/* Open-Drain is supported only on port 0 */
-			if (pin >= AW9523_PINS_PER_PORT) {
-				rc = -ENOTSUPP;
-				goto end;
-			}
+			if (pin >= AW9523_PINS_PER_PORT)
+				return -ENOTSUPP;
+
 			mask = AW9523_GCR_GPOMD_MASK;
 			val = 0;
 			break;
@@ -341,17 +340,15 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			val = AW9523_GCR_GPOMD_MASK;
 			break;
 		default:
-			rc = -ENOTSUPP;
-			goto end;
+			return -ENOTSUPP;
 		}
 
 		rc = regmap_update_bits(awi->regmap, reg, mask, val);
 		if (rc)
-			goto end;
+			return rc;
 	}
-end:
-	mutex_unlock(&awi->i2c_lock);
-	return rc;
+
+	return 0;
 }
 
 static const struct pinconf_ops aw9523_pinconf_ops = {
@@ -599,14 +596,14 @@ static int aw9523_gpio_get_multiple(struct gpio_chip *chip,
 	u8 m, state = 0;
 	int ret;
 
-	mutex_lock(&awi->i2c_lock);
+	guard(mutex)(&awi->i2c_lock);
 
 	/* Port 0 (gpio 0-7) */
 	m = *mask;
 	if (m) {
 		ret = _aw9523_gpio_get_multiple(awi, 0, &state, m);
 		if (ret)
-			goto out;
+			return ret;
 	}
 	*bits = state;
 
@@ -616,13 +613,12 @@ static int aw9523_gpio_get_multiple(struct gpio_chip *chip,
 		ret = _aw9523_gpio_get_multiple(awi, AW9523_PINS_PER_PORT,
 						&state, m);
 		if (ret)
-			goto out;
+			return ret;
 
 		*bits |= (state << 8);
 	}
-out:
-	mutex_unlock(&awi->i2c_lock);
-	return ret;
+
+	return 0;
 }
 
 static int aw9523_gpio_set_multiple(struct gpio_chip *chip,
@@ -632,30 +628,28 @@ static int aw9523_gpio_set_multiple(struct gpio_chip *chip,
 	struct aw9523 *awi = gpiochip_get_data(chip);
 	u8 mask_lo, mask_hi, bits_lo, bits_hi;
 	unsigned int reg;
-	int ret = 0;
+	int ret;
 
 	mask_lo = *mask;
 	mask_hi = *mask >> 8;
 	bits_lo = *bits;
 	bits_hi = *bits >> 8;
 
-	mutex_lock(&awi->i2c_lock);
+	guard(mutex)(&awi->i2c_lock);
 	if (mask_hi) {
 		reg = AW9523_REG_OUT_STATE(AW9523_PINS_PER_PORT);
 		ret = regmap_write_bits(awi->regmap, reg, mask_hi, bits_hi);
 		if (ret)
-			goto out;
+			return ret;
 	}
 	if (mask_lo) {
 		reg = AW9523_REG_OUT_STATE(0);
 		ret = regmap_write_bits(awi->regmap, reg, mask_lo, bits_lo);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-out:
-	mutex_unlock(&awi->i2c_lock);
-	return ret;
+	return 0;
 }
 
 static int aw9523_gpio_set(struct gpio_chip *chip, unsigned int offset,
@@ -695,16 +689,15 @@ static int aw9523_direction_output(struct gpio_chip *chip,
 	u8 regbit = offset % AW9523_PINS_PER_PORT;
 	int ret;
 
-	mutex_lock(&awi->i2c_lock);
+	guard(mutex)(&awi->i2c_lock);
 	ret = regmap_update_bits(awi->regmap, AW9523_REG_OUT_STATE(offset),
 				 BIT(regbit), value ? BIT(regbit) : 0);
 	if (ret)
-		goto end;
+		return ret;
 
 	ret = regmap_update_bits(awi->regmap, AW9523_REG_CONF_STATE(offset),
 				 BIT(regbit), 0);
-end:
-	mutex_unlock(&awi->i2c_lock);
+
 	return ret;
 }
 

-- 
2.51.0


