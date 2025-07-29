Return-Path: <linux-aspeed+bounces-1860-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ABCC87FCA
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Jul 2025 23:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsBLH5NpWz30Wn;
	Wed, 30 Jul 2025 09:26:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753780442;
	cv=none; b=hQjwRGbFVcb6xAFDHcXjQD9NibCyq/9VPhEPEnuRkXhU2tWAumIelk7kgDlyQVefkG/3U+jWdsi+iVhs7MgOGmm6IB3WtJfFNz8yTDJlGwxPbRIER31roEn14RwVaLXkuKozy0L3EfM0ymQJZY35RnA7XLrP5CwhWb5BGPLwM6n+WxnhBfTQX5HqkslBlcVdzdMa3tj7oiOgXRVhcT4fgQ/R+9enyLAvkPWUE0L4xB8CyxpN8w3eFIZtdxX/ZUkK+iVC/W+BCX+TVyu8DkvTXzE67z+HHbCx/QSU0GkEDx7YQqmpwqdbsyDYtkIJEEb/q6rC5eeVj8qBlVHLB/9FmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753780442; c=relaxed/relaxed;
	bh=Ybe/vNHybbFFD9CumA+Ao11VG7Qh745VMU9T9J4X9OI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evsjiCG8RE8SUOtZT4RFDzqfRdT3lhtPHXRmMXCrWjXoLWuLdXYSSBPfbHj43lrnyWLRG6e4MiX09M3GHY3S3TKkmYj+JmPG2fR2eehsZyFYBMIBlLwwX1U7imymv+WeBUFV7CkGYZAKva16Wqpv3XJxPGLBQYx3zat0oPA4xdfhwdrdk1pw4Ro7tpd6vbyTWroODXKqKE+ESy4H0ojvb454ic7G1wCfcD1jxoKHZKCwA9JPOcVy5W0K4hixqPdMstE8dvZ7H1OBChgwSpyFOh+MqIpgVoJZND+sVYhYyMEJc70Etd7wzcVMGPhjgS48fzR0o8cMloBJ0bCrjcNFWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g/ZGAbLO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g/ZGAbLO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brqQx3D3Wz2xRq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 19:14:01 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-748d982e92cso3428543b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780439; x=1754385239; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ybe/vNHybbFFD9CumA+Ao11VG7Qh745VMU9T9J4X9OI=;
        b=g/ZGAbLOdELyr4EYbAHFSatk2lkhjoWi5Mff9tEMrluj9t1hYuy9ZBqzZ77ncSdSiY
         CPkt8XuamQLwXCN0rrLDPHebGW2HH8LDLTmB+NkW/X1D6xoUpyfCluJ3+a+lPI0lA/z9
         gX0DwhtExFHAwgVLmupB7iY7A/+X1S9ttFZ7pvEa9bULOt/d4PFTt1qjjBLIptN9f3gZ
         N9eYdv3PHt118dqydvwzi30tZfQmovCCv90URJ8qscnU29AhlpelRMCMatabndKXx63o
         ukci2xggbL1GB0Q513XSMHffBP3e3OCREwhRpkjENOCspEwQMxq7ijqykYZGxBncJp8C
         JkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780439; x=1754385239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ybe/vNHybbFFD9CumA+Ao11VG7Qh745VMU9T9J4X9OI=;
        b=flCAxcEG1I8VWn9d7HWLQVS37tOfgvCuQBb4X15CjsfbIA3E1cY6K3YkQBC13vlL75
         2vWtRWjga4GlSISmUpP339QLWH5JSny7FXl08s4MTtkPR/PWzlzB7p/86BqaQwYNuNeT
         pwsv+VwbnV27rCwRZ10EEzoGcTWDFREfy5ENjOqwOapsA8gGk4xWjfD+ddmzc0h5VACN
         srRLsfHFnj1OuGUdX98d9B2B/k9/EXsg1bnqmn2HBdE5Rxl8IZ92L6+UX1oEWU0Svz84
         ufD3m9F7kaA9eyt2Z2SxUASKGrYfPL4rnCNdjx9Ce1lKOpYPXksc7mKevmfaSNW8XSam
         DIGg==
X-Forwarded-Encrypted: i=1; AJvYcCXgOl/9m1KdTXv1G6a1kWbuJR0JcySAX9D5ycw4k/cELscgKCIkKSFsEw6yaakJ/MZTHjQ51H9tUhjkZIA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJlShRTlg5J3HhoobkRpJredmrKhCao1qKUtD9KzsjvFWeSeAB
	xiTQ8dC+p98UQtwrYe6KV+8Af5Nwf35xWXi2rENXbKvAKbalUgnpUearsT0enA==
X-Gm-Gg: ASbGncuoqjVU1HijTuDtLE+2I7U3IrKBkgpk6I5NrXZRn1btKrGE/rj5MrkUIcBeghK
	Y/Bhq3zFfhQHgob8awMzxSakYSbHHJChESLCZhXpnC+9+HaWyTyLserKFtpGxGupreyk828wHI1
	N9QcgtXbjUg8md5qRaeNbNvnGC9iF/0ldgasSAX35dHoGgkDhVfeAassbueBOVrLvcAkhVfchqI
	jeDt2aMFKefeBOwBUCTtPH+M25ExuNvbLM+grk5qPGCPi3iRNEhmqoZIpgwzoLhQ27o5iWBFBtW
	VTTMlQ/6l5hxVQWT0GrFb9m5FTub+FDDBRwML+mtPYGY7Wc0mWb0DDjXcF4TTFKKojI5gtL4p1W
	47zatBaUEBz2bctqkroaM5tqrnpxIWzblLJbNkkjZgOzKyBH4JdVQd9j9ztueHFTYkiHT6v5k0M
	ADgFz9P6g9e4TxCndeU63IWvKHy5TxSzTkv2lJiTYFWB83drhL3aRS2vcaOA==
X-Google-Smtp-Source: AGHT+IGqVc8kW/CjjxVNzY8FasF+F5KZIuLBY5w92Xur7kp/aZMpOLaC9gys/5OjEFBRAksP1ITVVw==
X-Received: by 2002:a05:6a20:548d:b0:232:93c2:8851 with SMTP id adf61e73a8af0-23d700c695bmr23759842637.18.1753780439412;
        Tue, 29 Jul 2025 02:13:59 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e38d-c586-0429-5c72-053d-8858.emome-ip6.hinet.net. [2001:b400:e38d:c586:429:5c72:53d:8858])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b06ddsm7528612b3a.121.2025.07.29.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:13:59 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] ARM: dts: aspeed: santabarbara: add sensor support for extension boards
Date: Tue, 29 Jul 2025 17:13:43 +0800
Message-ID: <20250729091351.3964939-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

add power monitor and temperature sensors for extension boards in bus 6,
8, 10 and 13.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts      | 824 ++++++++++++++++++
 1 file changed, 824 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ee93a971c500..2f5712e9ba9f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -39,6 +39,38 @@ aliases {
 		i2c37 = &i2c12mux0ch5;
 		i2c38 = &i2c12mux0ch6;
 		i2c39 = &i2c12mux0ch7;
+		i2c48 = &i2c6mux0ch0;
+		i2c49 = &i2c6mux0ch1;
+		i2c50 = &i2c6mux0ch2;
+		i2c51 = &i2c6mux0ch3;
+		i2c52 = &i2c8mux0ch0;
+		i2c53 = &i2c8mux0ch1;
+		i2c54 = &i2c8mux0ch2;
+		i2c55 = &i2c8mux0ch3;
+		i2c56 = &i2c10mux0ch0;
+		i2c57 = &i2c10mux0ch1;
+		i2c58 = &i2c10mux0ch2;
+		i2c59 = &i2c10mux0ch3;
+		i2c60 = &i2c13mux0ch0;
+		i2c61 = &i2c13mux0ch1;
+		i2c62 = &i2c13mux0ch2;
+		i2c63 = &i2c13mux0ch3;
+		i2c64 = &i2c6mux1ch0;
+		i2c65 = &i2c6mux1ch1;
+		i2c66 = &i2c6mux1ch2;
+		i2c67 = &i2c6mux1ch3;
+		i2c68 = &i2c8mux1ch0;
+		i2c69 = &i2c8mux1ch1;
+		i2c70 = &i2c8mux1ch2;
+		i2c71 = &i2c8mux1ch3;
+		i2c72 = &i2c10mux1ch0;
+		i2c73 = &i2c10mux1ch1;
+		i2c74 = &i2c10mux1ch2;
+		i2c75 = &i2c10mux1ch3;
+		i2c76 = &i2c13mux1ch0;
+		i2c77 = &i2c13mux1ch1;
+		i2c78 = &i2c13mux1ch2;
+		i2c79 = &i2c13mux1ch3;
 	};
 
 	chosen {
@@ -574,6 +606,204 @@ eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
 	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c6mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@64 {
+				compatible = "microchip,mcp9600";
+				reg = <0x64>;
+			};
+
+			temperature-sensor@65 {
+				compatible = "microchip,mcp9600";
+				reg = <0x65>;
+			};
+
+			temperature-sensor@67 {
+				compatible = "microchip,mcp9600";
+				reg = <0x67>;
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c6mux1ch0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c6mux1ch1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					voltage-sensor@48 {
+						compatible = "ti,ads7830";
+						reg = <0x48>;
+					};
+
+					voltage-sensorr@49 {
+						compatible = "ti,ads7830";
+						reg = <0x49>;
+					};
+
+					temperature-sensor@4a {
+						compatible = "ti,tmp175";
+						reg = <0x4a>;
+					};
+
+					temperature-sensor@4b {
+						compatible = "ti,tmp175";
+						reg = <0x4b>;
+					};
+
+					eeprom@56 {
+						compatible = "atmel,24c256";
+						reg = <0x56>;
+					};
+				};
+				i2c6mux1ch2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c6mux1ch3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+		i2c6mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c6mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c6mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			voltage-sensor@37 {
+				compatible = "ti,adc128d818";
+				reg = <0x37>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp175";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp175";
+				reg = <0x49>;
+			};
+		};
+	};
 };
 
 &i2c7 {
@@ -588,6 +818,204 @@ eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
 	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c8mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@64 {
+				compatible = "microchip,mcp9600";
+				reg = <0x64>;
+			};
+
+			temperature-sensor@65 {
+				compatible = "microchip,mcp9600";
+				reg = <0x65>;
+			};
+
+			temperature-sensor@67 {
+				compatible = "microchip,mcp9600";
+				reg = <0x67>;
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c8mux1ch0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c8mux1ch1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					voltage-sensor@48 {
+						compatible = "ti,ads7830";
+						reg = <0x48>;
+					};
+
+					voltage-sensorr@49 {
+						compatible = "ti,ads7830";
+						reg = <0x49>;
+					};
+
+					temperature-sensor@4a {
+						compatible = "ti,tmp175";
+						reg = <0x4a>;
+					};
+
+					temperature-sensor@4b {
+						compatible = "ti,tmp175";
+						reg = <0x4b>;
+					};
+
+					eeprom@56 {
+						compatible = "atmel,24c256";
+						reg = <0x56>;
+					};
+				};
+				i2c8mux1ch2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c8mux1ch3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+		i2c8mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c8mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c8mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			voltage-sensor@37 {
+				compatible = "ti,adc128d818";
+				reg = <0x37>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp175";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp175";
+				reg = <0x49>;
+			};
+		};
+	};
 };
 
 &i2c9 {
@@ -619,6 +1047,204 @@ eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
 	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c10mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@64 {
+				compatible = "microchip,mcp9600";
+				reg = <0x64>;
+			};
+
+			temperature-sensor@65 {
+				compatible = "microchip,mcp9600";
+				reg = <0x65>;
+			};
+
+			temperature-sensor@67 {
+				compatible = "microchip,mcp9600";
+				reg = <0x67>;
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c10mux1ch0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c10mux1ch1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					voltage-sensor@48 {
+						compatible = "ti,ads7830";
+						reg = <0x48>;
+					};
+
+					voltage-sensorr@49 {
+						compatible = "ti,ads7830";
+						reg = <0x49>;
+					};
+
+					temperature-sensor@4a {
+						compatible = "ti,tmp175";
+						reg = <0x4a>;
+					};
+
+					temperature-sensor@4b {
+						compatible = "ti,tmp175";
+						reg = <0x4b>;
+					};
+
+					eeprom@56 {
+						compatible = "atmel,24c256";
+						reg = <0x56>;
+					};
+				};
+				i2c10mux1ch2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c10mux1ch3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+		i2c10mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c10mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c10mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			voltage-sensor@37 {
+				compatible = "ti,adc128d818";
+				reg = <0x37>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp175";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp175";
+				reg = <0x49>;
+			};
+		};
+	};
 };
 
 &i2c11 {
@@ -748,6 +1374,204 @@ eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
 	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c13mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@64 {
+				compatible = "microchip,mcp9600";
+				reg = <0x64>;
+			};
+
+			temperature-sensor@65 {
+				compatible = "microchip,mcp9600";
+				reg = <0x65>;
+			};
+
+			temperature-sensor@67 {
+				compatible = "microchip,mcp9600";
+				reg = <0x67>;
+			};
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c13mux1ch0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c13mux1ch1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					voltage-sensor@48 {
+						compatible = "ti,ads7830";
+						reg = <0x48>;
+					};
+
+					voltage-sensorr@49 {
+						compatible = "ti,ads7830";
+						reg = <0x49>;
+					};
+
+					temperature-sensor@4a {
+						compatible = "ti,tmp175";
+						reg = <0x4a>;
+					};
+
+					temperature-sensor@4b {
+						compatible = "ti,tmp175";
+						reg = <0x4b>;
+					};
+
+					eeprom@56 {
+						compatible = "atmel,24c256";
+						reg = <0x56>;
+					};
+				};
+				i2c13mux1ch2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+				i2c13mux1ch3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+		i2c13mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c13mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			potentiometer@2c {
+				compatible = "adi,ad5272-020";
+				reg = <0x2c>;
+			};
+
+			potentiometer@2e {
+				compatible = "adi,ad5272-020";
+				reg = <0x2e>;
+			};
+
+			potentiometer@2f {
+				compatible = "adi,ad5272-020";
+				reg = <0x2f>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c13mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			voltage-sensor@37 {
+				compatible = "ti,adc128d818";
+				reg = <0x37>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			power-monitor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp175";
+				reg = <0x48>;
+			};
+
+			temperature-sensor@49 {
+				compatible = "ti,tmp175";
+				reg = <0x49>;
+			};
+		};
+	};
 };
 
 &i2c14 {
-- 
2.49.0


