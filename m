Return-Path: <linux-aspeed+bounces-3378-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C758C98315
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:16:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvTwq4117z2yFd;
	Mon, 19 Jan 2026 10:16:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759831;
	cv=none; b=lqnfGurp56Ep39qFSFM6UNy2nO85jnvwrkkJbjDyadTWMyCAvhIPt0PqpMqXqkCF7UXaKo98PVz8L8Dz65Ft0vB12geD58nitldNzJemM6vv4GsT8XO8/ytN/QLQIOQ33vEZUJjqIAl1dfYFeiEkIKQhr9ogNW+N7vKaVH44RJ0AiJ4RZatDYw10d5+FtSawKWvsZWw7K6qFPZxlcJ9iPa8LK74Aw8Tv9mryO7dVLEc7zea2tcKrrtup9QMsWzZp48RtYhvIs0vSiP7jDlsmHsG0mbcPHHAc6+S0KBk6rCvMahB3Tz2mYonkxTshUtm/Ew2SoXbxZy25XY3mpP/M5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759831; c=relaxed/relaxed;
	bh=N48lIvtnLb2IcsLS8pOSE3K1e123fF19xLaS4IvtzNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvqiuDtYD2UbQjRl/CrJD/4eSXDdAxuwvPKwRvZd6X7h8xtMobVkUJYL1fAPFRSU0SiaVTMvysCxXZISSebSZpuO0RGfBgRl0K5IHoHz5uyybPCj8aFX6MGAk920bJfxTdFYJnQMQ51m4ZNvujnpjyR7arv4lL3I8vypvcYHqbBsKKhuTnK6ELKMfaA3nM9g15TH+hTy2AuQfph5nHczF5DeWxokvlhBeLUSZ0GNzbQQ9raGeSGSeVDGYd/9fgct/UhK+UgaNJditXti9SUX8W8FrIOrfGQWR0xO6B8CVeslj1I+maFHyfsb37SEAkb94igqyp/3hMXCN1MJU0nV1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CAJnBbDn; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VijULM9A; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CAJnBbDn;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VijULM9A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM871vl0z2xpt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:31 +1100 (AEDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I8oHgc2809169
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N48lIvtnLb2IcsLS8pOSE3K1e123fF19xLaS4IvtzNQ=; b=CAJnBbDnA61W8ImL
	SnAgPRZ26uidWw6/crkIz13LXLfpToynIHrH8fGSxXxetED4wm5RJiZrZDg3rIfp
	I+yQhrd1CBcJ2Ad1lFGyf0FsGqwUca3zvkkfCL3ZCW32iOW4+BU+zFImpamvkP5L
	3osMGujdYac1/k+nkBafEmhc9umBL/i3W2CHMm3rb7+w1xHJXWCVXvQUKh2K6id9
	bp6GniMk26pToQycFEVVN2Av0pqMYej4EFc/gwjGx53qUMEe/dVECDdxjQSVVBKJ
	QGMQkydLLEne96NU+CuKEKwSYdrZH2VFYby+MaKWI8kzKlyfM27gyaBY1pIwxY0N
	TkbXFg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br36darsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52af6855fso497427285a.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759828; x=1769364628; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N48lIvtnLb2IcsLS8pOSE3K1e123fF19xLaS4IvtzNQ=;
        b=VijULM9ADTLsnQZuxZthlECci0BtANMzXWDRexoYl7Rs/NogKweMhLC8zA/0J/tY4U
         wQp/Anf034Q8gwLNbtJivkAfnXUFd/ZTqRgZp4TqSd/o9N/QX9GpqGNAM/khagbhWcn7
         Z7VP4+n1dZCukptNfhRM6opjORaqR9g6cyQnkPy263uutZ3CA8BPBoEVCPi//3Gr7RBi
         fvRG6b3MEo9uW9YBtX+8D87wd2ZhAmKwKdQwXG0WlMZKWkEus98cfrvnSsYND/zL0gL1
         fdu3SChNNpbfFd/TYFrf8lcJTEN1sXYw00zZhTz7+t+DwUTq6AYwX18p8d4b5h66vIJY
         mD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759828; x=1769364628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N48lIvtnLb2IcsLS8pOSE3K1e123fF19xLaS4IvtzNQ=;
        b=jACE2TwryyILcfwZ2cJwmdZaXu3cKF4r0xECl9w8aaJ0ay3S+YGXR3ZyX0rIOktnhz
         BWL7YjbWjckxwJXtN5tLCkqmjVNdspTUDYk36AR92f9s1pXSLVQDTgV+yn8b2aFG2MbB
         jxYuADMhf8c2FAoIaKsEXFdcj+0Clt5TUxTCU0EWtXpkp4ifx+MWlVbNCEO8gSqdfRYk
         YgICI0bKIcYYR6FgIGcjvotx3j9Nv1miQOby2XiVpsw0zJN/tPj/Tadt47OAI2dIgsGA
         Q6yq7TvS7ydefAPtppSCckHximP83CAZaCqjohbppcdnJPGx0t0j1gtdmy1qiXdZT3TA
         sdzg==
X-Gm-Message-State: AOJu0YwSR2jViYqicgw46ivJe6zY2WKDPs4M3KycosLmKhJ39RytQImj
	Bz1+6yWLhkvhfizFt0xIcZ3YkDYYCBNifLFcwNWmuasbWCT3VmdjZ4ua7M97KEc1VZ2VTTf07gJ
	TXQANvvDLfcMC86F0R0BpMR9HL/kWCQcEn4yncM96g3lHbB066v3QAwiFHYil6tRHdKQc
X-Gm-Gg: AY/fxX7/aeAcAgLXNoX5gx0F9416bDgOjAU1Ahs62rZLN1QToGOBEgyPw4vsjHTBMA+
	Nsxhhu5I4TBn9zhovlv2PqPaY3GzQ8mQxm7/nzcX5HS8pobVnykLq76gbVXWJ2oE0LcsAGMbTJO
	MkRe0PrkZDxyZPQgQouExYekpe9mIagjZiH1nnDu08XRAJhxm7mcojMrO2EDTrxdmNP1f5rAPaR
	b+Sw80Dc6QLHGS0pj7CzHWzxBIyVo+ywVwZJf6mc6UWDra+sM/cU5hgmlOe6SAT6uTAwZf3Fl3O
	44fmmm3FNNJTRL4xLxvWaP6aL0PRT1dnpLyBFzM5WKgHq5LfwlKiIROhrxPiy0j7VldKF7EEvbA
	IQ7A1pgtprjEZk2HaO269BZ6mbz1WJTNSFw==
X-Received: by 2002:a05:620a:2808:b0:8c1:ab1c:f2da with SMTP id af79cd13be357-8c6a67b79c5mr1285493985a.70.1768759828474;
        Sun, 18 Jan 2026 10:10:28 -0800 (PST)
X-Received: by 2002:a05:620a:2808:b0:8c1:ab1c:f2da with SMTP id af79cd13be357-8c6a67b79c5mr1285491785a.70.1768759828043;
        Sun, 18 Jan 2026 10:10:28 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 19:09:34 +0100
Subject: [PATCH v2 11/11] pinctrl: st: Annotate st_pinconf_dbg_show() as
 holding mutex
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
Message-Id: <20260118-pinctrl-cleanup-guard-v2-11-bd36f681bdc0@oss.qualcomm.com>
References: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
In-Reply-To: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=k1GvsBNYWO8pFPyazMMNabsh3Vpjdc1LSTY4GGhIuOk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSH3xTqF1UPuWpw21q5i4y/0ItOY7uFl5LJRk
 I/zBJTe0SiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h9wAKCRDBN2bmhouD
 14rID/9CmPz1fyhRfWxv8BXOtmT8JzPxM3Qn1vrvoEw3Redb2US4V07grJBDpsNMH2yrzXble41
 qSybWyUX5o3mUWc71wO3IsMFu4uIK1mOxv3WeIRfETEaVH6Sn7DYx472fLtIqS9oZ+qA+sCBJja
 VZqb59C2Wu6FxIQy5jRXgkXFhzpMZX0nRzYzDwyQb/gPSnWoiBOSRkxbAxvnAWqmPNWAHehSuS+
 S3lTrzXTkY98p1nxFqfdeU8afywPvhvwDpfmevQNjxy7iF3EVPf2z4pyHTOQREBUBBmC1perTa0
 ANxtLXo2E8BaPttpb8EoZLHxfX7PIAA3ibfLPS0dPI9Yhlhkq9HgRSbSvTKCGxLSk4sxrjTofoP
 8reJpHpMVSLdOfwPApz5sWcX+oq/L74sPON1vtXunQcS1QSf50DL+Abn0WjuoQWPqg6LsySITQc
 oE9X/C6PfDtxOP7YFCEU74SomVt5ZtAwYGK9tgAjJIhKXro4U0APc9TE5T0ekdeapQyKRAkQIlh
 2oeg70iEhT2N/f16R6mk9EaIeneSiNYN/wqgMiPo418GRPwnMZVANUWr/har+gk+z3ScAHAYU4w
 LCmu/3TUFx8+BZXGjyqMjtcINUApT5RxEOVxvgAkv9Z4jn0eIIZd+UQuZn5nKG9jKV3FlgN0K7J
 BiN1rYOCb1j6Hng==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MCBTYWx0ZWRfX0RMDySuS7a3q
 5mwef1GUPms/ymadjAb97rpzXgTKoGRX21C+DNuNmZ/P+0x/pfeIPnhnyOgKGpM/ClAfsbBaKYs
 IHAs3m+BP9bwFNFL+t+5+4qEoUFgNydj1BQC/9ZcQK/xy4zXPNDFCs3TTL+mRwr6zYOqX/TO4VA
 6u6cwCaEvU6zUq7PqAR2gbmFMlYtOE91gbn5nUC0A1IFdKJVH/u7beJ2vWCLmdaIQzRKI95RDEP
 bBPjNScATJN1RQjvxRa7DArskAu6UEAq93K0oZcM5FNtiYDyPWzW7drL5HhNod1Rg/GkUI8wAq2
 m80Piwqo8OvRgxg7JzXVTlhiGwjT78JdGNrzdNYx3oNfXAFS6r8Upy9LnqdPq/MqCsDeT991psI
 mOwOBBWwG25KI2UrFfr/sQZ+BjAiEf0ZHc+WnhcEnITancbHdnpKoCvgssEvLHSFgIv6S67REa4
 SMVsAUtumDRnozYq+6Q==
X-Proofpoint-GUID: qox6GpwZk2UHu8PuQquFrEAckxXTLnvp
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=696d2215 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=EUspDBNiAAAA:8
 a=RIxbnQC35JVfspY8PfAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: qox6GpwZk2UHu8PuQquFrEAckxXTLnvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601180160

st_pinconf_dbg_show() unlocks and locks the pinctrl_dev mutex, so it
must be called by the pinctrl core with the mutex hold.  Annotate the
function with sparse __must_hold, so any changes in pinctrl locking will
be statically detected.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

I think this is still useful, although maybe a bit pointless if core
explicitly always locks every pin_config_dbg_show() call? Anyway,
pattern of unlock+lock feels to me like something worth annotating.

I left the patch at the end of the set so it can be nicely discarded.
---
 drivers/pinctrl/pinctrl-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index d3cea3437d7f..8ce88e591f47 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -987,6 +987,7 @@ static int st_pinconf_get(struct pinctrl_dev *pctldev,
 
 static void st_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				   struct seq_file *s, unsigned pin_id)
+	__must_hold(&pctldev->mutex)
 {
 	struct st_pio_control *pc;
 	unsigned long config;

-- 
2.51.0


